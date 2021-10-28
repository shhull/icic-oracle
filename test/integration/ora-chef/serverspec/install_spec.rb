require 'serverspec'

set :backend, :exec

#Testing of the Oracle and Listener of process
%w{oracleorcl ora_pmon_orcl ora_smon_orcl ora_lgwr_orcl ora_arc0_orcl ora_arc1_orcl ora_arc2_orcl ora_arc3_orcl ora_mmon_orcl tnslsnr}.each do |process|
  describe command("ps -eo command | egrep #{process} | egrep -v egrep") do
    its(:exit_status) { should eq 0 }
  end
end

#Testing of the Enterprise Manager of process
describe process("java") do
  its(:user) { should eq "oracle" }
  its(:args) { should match /-config \/u01\/app\/oracle\/product\/19.3.0\/dbhome_1\/oc4j\/j2ee\/OC4J_DBConsole_ora-chef-OracleLinux5_orcl\/config\/server.xml\b/ }
end

#Testing of the listener configuration file
describe file('//u01/app/oracle/product/19.3.0/dbhome_1/network/admin/listener.ora') do
  it { should exist }
  its(:content) { should match /\(ADDRESS=\(PROTOCOL=tcp\)\(HOST=localhost.localdomain\)\(PORT=1521\)\)/ }
end

#listener testing by lsnrctl command
describe command('su - oracle -c "lsnrctl status"') do
  its(:stdout) { should match /\(DESCRIPTION=\(ADDRESS=\(PROTOCOL=tcp\)\(HOST=ora-chef-OracleLinux5\)\(PORT=1521\)\)\)/ }
end

#Connection test to SQL*Plus
describe command('su - oracle -c "sqlplus -s / as sysdba <<EOF
set lin 1000
set pages 0
set trims on
set tab off
select NAME||\',\'||VALUE line from v\\\\\\$parameter2 order by num ;
exit
EOF
"') do
  its(:stdout) { should match /processes,1000/ }
end
