require 'serverspec'

set :backend, :exec

# #Check the required packages are installed
# %w{compat-libstdc++-33 libaio-devel unixODBC unixODBC-devel}.each do |pkg|
#   describe package( pkg ) do
#     it { should be_installed }
#   end
# end

#Check the required groups have been created
%w{oinstall dba oper}.each do |grp|
  describe group( grp ) do
    it { should exist }
  end
end

#Check the required user has been created
describe user('oracle') do
  it { should exist }
  it { should belong_to_group 'oinstall' }
  it { should belong_to_group 'dba' }
  it { should have_home_directory '/home/oracle' }
  it { should have_login_shell '/bin/bash' }
end

#Check bash_profile has been created
describe file('/home/oracle/.bash_profile') do
  it { should exist }
  its(:content) { should match /ORACLE_BASE/ }
  its(:content) { should match /ORACLE_HOME/ }
  its(:content) { should match /ORACLE_SID/ }
  its(:content) { should match /LD_LIBRARY_PATH/ }
  its(:content) { should match /NLS_LANG/ }
end

#Check the required directories have been created
%w{ oracle oracle/product/19.3.0/dbhome_1 oradata oraInventory }.each do |dir|
  describe file("/u01/app/#{dir}") do
    it { should be_directory }
    it { should be_owned_by 'oracle' }
    it { should be_grouped_into 'oinstall' }
  end
end

#Check the required files have been created
describe file('/etc/sysctl.conf') do
  it { should exist }
  its(:content) { should match /fs.aio-max-nr/ }
  its(:content) { should match /fs.file-max/ }
  its(:content) { should match /kernel.shmall/ }
  its(:content) { should match /kernel.shmmax/ }
  its(:content) { should match /kernel.shmmni/ }
  its(:content) { should match /kernel.sem/ }
  its(:content) { should match /net.ipv4.ip_local_port_range/ }
  its(:content) { should match /net.core.rmem_default/ }
  its(:content) { should match /net.core.rmem_max/ }
  its(:content) { should match /net.core.wmem_default/ }
  its(:content) { should match /net.core.wmem_max/ }
end

describe file('/etc/security/limits.conf') do
  it { should exist }
  its(:content) { should match /oracle soft nproc/ }
  its(:content) { should match /oracle hard nproc/ }
  its(:content) { should match /oracle soft nofile/ }
  its(:content) { should match /oracle hard nofile/ }
  its(:content) { should match /oracle soft stack/ }
end
