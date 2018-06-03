name 'windows_base_cookbook'
maintainer 'Cosmin Banciu'
maintainer_email 'cosmin.banciu667@gmail.com'
license 'Apache 2.0'
description 'Base configuration for Windows 20012 R2 and Windows 10'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.0.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

supports windows

depends 'aws'
depends 'chef-client'
depends 'firewall'
depends 'java_se'
depends 'ohai'
depends 'powershell'
depends 'chocolatey'
depends 'sysinternals'

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
issues_url 'https://bitbucket.org/user/windows_base_cookbook/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
source_url 'https://bitbucket.org/user/windows_base_cookbook'
