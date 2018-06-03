# attributes for chef-client schedulled task
default['chef_client']['task']['frequency_modifier'] = '10'

# attributes for chocolatey
default['chocolatey']['upgrade'] = 'true'

# attributes for Sysinternals and BGInfo
override['sysinternals']['url'] = 'http://download.sysinternals.com/files/SysinternalsSuite.zip'
override['sysinternals']['install_dir'] = 'C:\SysinternalsSuite'
override['sysinternals']['bginfo_config_url'] = 'https://download.sysinternals.com/files/BGInfo.zip'
override['sysinternals']['bginfo_config_dir'] = 'C:\BgInfo'
