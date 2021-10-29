#
# Cookbook Name:: oracle
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'oracle::setup'
include_recipe 'oracle::installsw'
include_recipe 'oracle::installdb'
# include_recipe 'oracle::installem'
