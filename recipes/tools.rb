# Cookbook:: role_windows_base
# Recipe:: tools
#
# Copyright::Cosmin Banciu 2017, The Authors, All Rights Reserved.

include_recipe 'chocolatey'
include_recipe 'java_se'
include_recipe 'sysinternals'

# Load creadentials from default data bag
aws_creds = data_bag_item('aws', 'athena_aws_keys')

# Create the aws credentials file for user user
template 'c:\Users\user\.aws\credentials' do
  source 'aws_credentials.erb'
  variables(aws_creds: aws_creds)
  sensitive true
end

# Create the aws config file for user user
template 'c:\Users\user\.aws\config' do
  source 'aws_config.erb'
  variables(region: aws_creds['aws_region'])
end

# download and install aws cli
execute 'install_aws_cli' do
  command 'Powershell -c Invoke-WebRequest -Uri "https://s3.amazonaws.com/aws-cli/AWSCLI64.msi" -OutFile "c:\tools\AWSCLI64.msi"'
  not_if { ::File.exist?('c:\tools\AWSCLI64.msi') }
end
execute 'install_aws_cli' do
  command 'msiexec /i "c:\tools\AWSCLI64.msi" /quiet /qn /norestart /log "c:\tools\AWSCLI64_install.log"'
  not_if { ::File.exist?('c:\tools\AWSCLI64_install.log') }
end

# sync S3 aws tools folder with local folder
# execute 'sync_tools_folder' do
#   command 'cmd.exe /c "aws s3 sync s3://merlindomx232/tools c:\tools"'
#   user '.\\user'
#   password node.default['user']['password']
#   environment ({'HOME' => 'c:\Users\user'})
#   action :run
# end

# testing for windows versions and installing optional features/tools
require 'chef/win32/version'
windows_version = Chef::ReservedNames::Win32::Version.new

# if windows 10 detected install required optional features and tools
# for windows 10 also set the firewall
if node['platform_version'] == '10.0.14393'
  Chef::Log.info('Windows 10 detected')
  windows_feature 'TelnetClient' do
    action :install
  end
  %w[git 7zip notepadplusplus GoogleChrome Console2 winrar firefox putty.install
     notepadplusplus.install filezilla dotnet4.5 putty atom procexp
     conemu poshgit].each do |pack|
    chocolatey_package pack
  end
  include_recipe 'firewall'
  include_recipe 'windows_base_cookbook::firewall'
end

# if windows 2012 R2 detected install required features and tools
if windows_version.windows_server_2012_r2?
  Chef::Log.info('Windows 2012 R2 detected, installing features and tools')
  %w[IIS-WebServerRole IIS-WebServer NetFx4Extended-ASPNET45
     IIS-ManagementService].each do |feature|
    windows_feature feature do
      action :install
    end
    %w[git 7zip firefox putty.install
       notepadplusplus.install filezilla putty procexp].each do |pack|
      chocolatey_package pack
    end
  end
end
