# Cookbook:: windows_base_cookbook
# Recipe:: main
#
# Copyright::Cosmin Banciu 2017, The Authors, All Rights Reserved.

include_recipe 'aws'
include_recipe 'ohai'
include_recipe 'powershell'

# add windows users
windows_users = data_bag('windows_users')
windows_users.each do |user|
  windows_user = data_bag_item('windows_users', user)
  # add user password to node hash for later use
  node.default[windows_user['id']]['password'] = windows_user['password']
  user windows_user['id'] do
    password windows_user['password']
  end
  # add users to their main user group
  group windows_user['group'] do
    action :modify
    members windows_user['id']
    append true
  end
end

# chef-client schedulled task
include_recipe 'chef-client'

# create folders
%w[c:\temp c:\tools C:\Users\user c:\Users\user\.aws].each do |folder|
  directory folder do
    inherits true
    action :create
  end
end

# import the PS library for changing UserRightsAssignment policies
template 'c:\chef\cache\UserRights.ps1' do
  source 'UserRights.ps1.erb'
  action :create
end

# Disable firewall and setup winrm (why? because we prefer AWS Security Groups,
# Router firewalls and we want to work unrestricted in our LAN network)
template 'c:\chef\cache\windows_powershell.ps1' do
  source 'windows_powershell.ps1.erb'
  action :create
end
powershell_script 'windows_powershell.ps1' do
  code '. c:\chef\cache\windows_powershell.ps1'
  :immediate
end
