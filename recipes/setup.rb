#
# Cookbook Name:: oracle
# Recipe:: setup
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# #Package requirements install
# node['oracle']['setup']['packages'].each do |pkg|
#   package pkg do
#     action  :install
#   end
# end

#groupadd oinstall
group 'oinstall' do
  gid  node['oracle']['setup']['oinstall_gid']
  action  :create
end

#groupadd dba
group 'dba' do
  gid  node['oracle']['setup']['dba_gid']
  action  :create
end

#groupadd oper
group 'oper' do
  gid  node['oracle']['setup']['oper_gid']
  action  :create
end

#useradd oracle
user 'oracle' do
  uid  node['oracle']['setup']['oracle_uid']
  gid  node['oracle']['setup']['oinstall_gid']
  shell  '/bin/bash'
  action  :create
  not_if "grep oracle /etc/passwd"
end

#chpasswd user oracle
execute 'chpasswd_oracle' do
  command "echo oracle:#{node['oracle']['setup']['user_password']} | /usr/sbin/chpasswd"
end

#groups dba and oper members user oracle
%w{dba oper}.each do |grp|
  group grp do
    action  :modify
    members  'oracle'
    append  true
  end
end

#Configuration of the oracle user environment
template '/home/oracle/.bash_profile' do
  source 'bash_profile.erb'
  owner 'oracle'
  group 'oinstall'
  mode '0644'
  action :create
  not_if "grep 'ORACLE_HOME' /home/oracle/.bash_profile"
end

#mkdir ORACLE Directory
[node['oracle']['setup']['oracle_dir'], node['oracle']['setup']['oracle_base'], node['oracle']['setup']['oracle_inventry'] ].each do |dir|
  directory dir do
    owner 'oracle'
    group 'oinstall'
    mode '0775'
    recursive true
    action :create
  end
end

#Reload the sysctl.conf
execute 'sysctl-p' do
  command "/sbin/sysctl -p"
  action :nothing
end

#Kernel parameter settings
template '/etc/sysctl.conf' do
  source  'sysctl.conf.erb'
  action  :create
  not_if "grep 'fs.aio-max-nr = 1048576' /etc/sysctl.conf"
  notifies :run, 'execute[sysctl-p]', :immediately
end

#Setting the Oracle user's shell limit
template '/etc/security/limits.conf' do
  source  'limits.conf.erb'
  action  :create
  not_if "grep 'oracle soft nproc 2047' /etc/security/limits.conf"
end
