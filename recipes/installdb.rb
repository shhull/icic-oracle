#
# Cookbook Name:: oracle
# Recipe:: installdb
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#Deployment of the dbca template
template "#{node['oracle']['setup']['oracle_home']}/assistants/dbca/dbca.rsp" do
  source 'dbca.rsp.erb'
  owner 'oracle'
  group 'oinstall'
  mode '0644'
end

#Create Database
bash 'dbca_create_db' do
   environment (node['oracle']['setup']['env'])
   code "sudo -Eu oracle ./dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbname #{node['oracle']['setup']['oracle_sid']} -sid #{node['oracle']['setup']['oracle_sid']} -sysPassword #{node['oracle']['setup']['db_password']} -systemPassword #{node['oracle']['setup']['db_password']}"
end


#sudo -Eu oracle ./netca -silent -responsefile /home/u19/assistants/netca/netca.rsp
#sudo -Eu oracle ./lsnrctl start LISTENER
#sudo -Eu oracle ./dbca -silent -createDatabase -templateName General_Purpose.dbc -gdbname icic2 -sid icic2 -sysPassword dfltpass -systemPassword dfltpass -characterSet AL32UTF8