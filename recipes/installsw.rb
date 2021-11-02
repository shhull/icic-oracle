#
# Cookbook Name:: oracle
# Recipe:: installsw
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#Transfer installation files
remote_directory "/usr/local/src/database" do
  source 'database'
  owner 'oracle'
  group 'oinstall'
  mode "0775"
  recursive true
end

#Copy database installation files into ORACLE_HOME
bash 'copy_oracle_home' do
  cwd "#{node['oracle']['setup']['install_dir']}"
  code "sudo -Eu oracle cp -r /usr/local/src/database/* ."
end


#Deployment of the response file for runInstaller
template "#{node['oracle']['setup']['install_dir']}/install/response/db_install.rsp" do
  source 'db_install.rsp.erb'
  owner 'oracle'
  group 'oinstall'
  mode '0644'
end

#Permission settings of the installation file
execute 'chown_database_install_files' do
  command <<-"EOH"
    chown -R oracle:oinstall #{node['oracle']['setup']['install_dir']}
    chmod -R 775 #{node['oracle']['setup']['install_dir']}
  EOH
  action :run
  only_if { ::File.exists?("#{node['oracle']['setup']['install_dir']}") }
end

#run ./runInstaller
bash 'run_installer_swonly' do
  cwd "#{node['oracle']['setup']['install_dir']}"
  environment  (node['oracle']['setup']['env'])
  code "sudo -Eu oracle ./runInstaller -silent -waitForCompletion -ignorePrereqFailure -responseFile #{node['oracle']['setup']['install_dir']}/install/response/db_install.rsp"
  returns [0, 253]
end

#Run root.sh
bash 'run_rooot' do
  cwd "#{node['oracle']['setup']['install_dir']}"
  code "sh root.sh"
end

#start the licenstener
bash 'run_listener' do
  cwd "#{node['oracle']['setup']['install_dir']}/bin"
  environment  (node['oracle']['setup']['env'])
  code "sudo -Eu oracle ./netca -silent -responseFile #{node['oracle']['setup']['install_dir']}/assistants/netca/netca.rsp"
  returns [0, 253]
end

#Deployment of the listener.ora
template "#{node['oracle']['setup']['install_dir']}/network/admin/listener.ora" do
  source 'listener.ora.erb'
  owner 'oracle'
  group 'oinstall'
  mode '0644'
end

#Start the listener
execute 'start_listener' do
  command "#{node['oracle']['setup']['install_dir']}/bin/lsnrctl start"
  environment  (node['oracle']['setup']['env'])
  user 'oracle'
  group 'oinstall'
  action :run
end
