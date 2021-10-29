#
# Cookbook Name:: oracle
# Recipe:: installsw
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# #Transfer installation files
# remote_directory "#{node['oracle']['setup']['install_dir']}/database" do
#   source 'database'
#   owner 'oracle'
#   group 'oinstall'
#   mode "0775"
#   recursive true
# end

# #Remove the ORACLE_HOME 
# bash 'remove_oracle_home' do
#   cwd "#{node['oracle']['setup']['install_dir']}"
#   environment  (node['oracle']['setup']['env'])
#   code "sudo -Eu oracle ./runInstaller -silent -detachHome ORACLE_HOME=#{node['oracle']['setup']['install_dir']}"
# end

# #Deployment of the response file for deinstall
# template "#{node['oracle']['setup']['install_dir']}/install/response/deinstall.rsp.tmpl" do
#   source 'deinstall.rsp.erb'
#   owner 'oracle'
#   group 'oinstall'
#   mode '0644'
# end

# #Remove the ORACLE_HOME 
# bash 'deinstall_oracle_home' do
#   cwd "#{node['oracle']['setup']['install_dir']}/deinstall/"
#   environment  (node['oracle']['setup']['env'])
#   code "sudo -Eu oracle ./deinstall -paramfile #{node['oracle']['setup']['install_dir']}/install/response/deinstall.rsp.tmpl"
#   returns [0, 253]
# end

#Deployment of the response file for runInstaller
template "#{node['oracle']['setup']['install_dir']}/install/response/db_install.rsp" do
  source 'db_install.rsp.erb'
  owner 'oracle'
  group 'oinstall'
  mode '0644'
end

# #Permission settings of the installation file
# execute 'chown_database_install_files' do
#   command <<-"EOH"
#     chown -R oracle:oinstall #{node['oracle']['setup']['install_dir']}/database
#     chmod -R 775 #{node['oracle']['setup']['install_dir']}/database
#   EOH
#   action :run
#   only_if { ::File.exists?("#{node['oracle']['setup']['install_dir']}/database") }
# end

# #Remove files under the ORACLE_BASE and ORACLE_INVENTRY if exists
# execute 'remove_install_directory' do
#   command <<-"EOH"
#     rm -rf #{node['oracle']['setup']['oracle_base']}/*
#     rm -rf #{node['oracle']['setup']['oracle_inventry']}/*
#   EOH
#   action :run
#   only_if { ::File.exists?("#{node['oracle']['setup']['oracle_home']}") }
# end

#run ./runInstaller
bash 'run_installer_swonly' do
  cwd "#{node['oracle']['setup']['install_dir']}"
  environment  (node['oracle']['setup']['env'])
  code "sudo -Eu oracle ./runInstaller -silent -waitForCompletion -ignorePrereqFailure -responseFile #{node['oracle']['setup']['install_dir']}/install/response/db_install.rsp"
  returns [0, 253]
end

#run root.sh as root
execute 'run_root.sh' do
  command "#{node['oracle']['setup']['install_dir']}/root.sh"
  action :run
end

# #Deployment of the listener.ora
# template "#{node['oracle']['setup']['install_dir']}/network/admin/samples/listener.ora" do
#   source 'listener.ora.erb'
#   owner 'oracle'
#   group 'oinstall'
#   mode '0644'
# end

# #Start the listener
# execute 'start_listener' do
#   command "#{node['oracle']['setup']['install_dir']}/bin/lsnrctl start"
#   environment  (node['oracle']['setup']['env'])
#   user 'oracle'
#   group 'oinstall'
#   action :run
# end
