# Cookbook:: windows_base_cookbook
# Recipe:: default
#
# Copyright:: 2018, Cosmin Banciu, All Rights Reserved.

case node['platform_family']
when 'windows'
  include_recipe 'windows_base_cookbook::main'
  include_recipe 'windows_base_cookbook::tools'
else
  Chef::Log.debug('Cookbook built only for Windows 2012 R2 and Windows 10')
  Chef::Log.info('Cookbook built only for Windows 2012 R2 and Windows 10')
end
