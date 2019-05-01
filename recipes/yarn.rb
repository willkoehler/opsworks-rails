# Add a new PPA for Yarn and install Yarn package
#
# This will probably be built into opsworks_ruby in the future. See https://github.com/ajgon/opsworks_ruby/pull/216
# But for now see: https://github.com/ajgon/opsworks_ruby/issues/80
# Official Yarn install steps for Ubuntu https://yarnpkg.com/lang/en/docs/install/#debian-stable

# We need to install apt keys manually in Ubuntu 18.04. The "key" attribute of apt_repository doesn't work
# See https://github.com/chef/chef/issues/5831 (referenced from https://github.com/chef-cookbooks/apt/issues/216)
# Change to Chef that fixes this https://github.com/chef/chef/commit/6309edcc89e6b606f7b5cf8e82c20bbdd8d91487
# This fix doesn't appear to be in the version of Chef that OpsWorks uses (12.18.31)
# https://github.com/chef/chef/compare/v12.18.31...master#diff-bebf53f73971986ff320054ee72c1293L150
# This appears to be the Ubuntu change that required the updates to Chef https://askubuntu.com/a/846877/376611
execute 'setup yarn repository key' do
  command 'curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -'
end

apt_repository 'yarn' do
  uri 'https://dl.yarnpkg.com/debian/'
  distribution 'stable'
  components ['main']
  # (doesn't work in Ubuntu 16.10+) key 'https://dl.yarnpkg.com/debian/pubkey.gpg'
  action :add
end

package 'yarn'
