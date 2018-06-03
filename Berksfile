def cos_cookbook(name, version = '>= 0.0.0', options = {})
  cookbook(name, version, {
    git: "git@bitbucket.org:user/#{name}.git"
   }.merge(options))
end

def local_cookbook(cookbook_dir, version = '>= 0.0.0', options = {})
  cookbook(cookbook_dir, version, {
    path: "#{ENV['CHEF_COOKBOOK_HOME']}/cookbooks/#{cookbook_dir}"
   }.merge(options))
end

source 'https://supermarket.getchef.com'

metadata

cookbook 'aws'
cookbook 'chef-client'
cookbook 'firewall'
cookbook 'java_se'
cookbook 'ohai'
cookbook 'powershell'
cookbook 'chocolatey'
cookbook 'sysinternals'
