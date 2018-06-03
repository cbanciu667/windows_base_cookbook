# Cookbook:: role_windows_base
# Recipe:: firewall
#
# Copyright::Cosmin Banciu 2017, The Authors, All Rights Reserved.



# windows firewall
firewall 'default' do
  action :install
end
firewall_rule 'rdp_work' do
  port     3389
  source   '86.125.101.101/32'
  command  :allow
end
firewall_rule 'rdp_lan' do
  port     3389
  source   '192.168.5.0/24'
  command  :allow
end
firewall_rule 'rdp_home' do
  port     3389
  source   '82.78.146.100/32'
  command  :allow
end
firewall_rule 'WinRMCustom-HTTP' do
  port     5985
  command  :allow
end
firewall_rule 'WinRMCustom-HTTPS' do
  port     5986
  command  :allow
end
