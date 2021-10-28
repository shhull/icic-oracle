#
# Cookbook Name:: oracle
# Recipe:: installem
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#Deployment of the response file for emca
template "#{node['oracle']['setup']['install_dir']}/database/response/em_install.rsp" do
  source 'em_install.rsp.erb'
  owner 'oracle'
  group 'oinstall'
  mode '0644'
end

#Configure Enterprise Manager
bash 'run_emca' do
   environment (node['oracle']['setup']['env'])
   code "sudo -Eu oracle emca -config dbcontrol db -repos create -respFile #{node['oracle']['setup']['install_dir']}/database/response/em_install.rsp"
end

#Configure the EM to unsecure
bash 'unsecure_em' do
   environment (node['oracle']['setup']['env'])
   code <<-"EOH"
     sudo -Eu oracle emctl stop dbconsole
     sudo -Eu oracle emctl unsecure dbconsole
     sudo -Eu oracle emctl start dbconsole
   EOH
   action :run
   not_if { node['oracle']['em']['secure'] == 'true' }
end
