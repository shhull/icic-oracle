#
# Cookbook Name:: oracle
# Recipe:: installdb
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#Deployment of the dbca template
template "#{node['oracle']['setup']['oracle_home']}/assistants/dbca/templates/db_create.dbt" do
  source 'db_create.dbt.erb'
  owner 'oracle'
  group 'oinstall'
  mode '0644'
end

#Create Database
bash 'dbca_create_db' do
   environment (node['oracle']['setup']['env'])
   code "sudo -Eu oracle dbca -silent -createDatabase -templateName db_create.dbt -gdbname #{node['oracle']['setup']['oracle_sid']} -sid #{node['oracle']['setup']['oracle_sid']} -sysPassword #{node['oracle']['setup']['db_password']} -systemPassword #{node['oracle']['setup']['db_password']}"
end
