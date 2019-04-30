# Add a new PPA for Yarn and install Yarn package
#
# This will probably be built into opsworks_ruby in the future. See https://github.com/ajgon/opsworks_ruby/pull/216
# But for now: https://github.com/ajgon/opsworks_ruby/issues/80#issuecomment-300164162
# Official Yarn install steps for Ubuntu https://yarnpkg.com/lang/en/docs/install/#debian-stable

apt_repository 'yarn' do
  uri          'https://dl.yarnpkg.com/debian/'
  distribution 'stable'
  components   ['main']
  key          'https://dl.yarnpkg.com/debian/pubkey.gpg'
end

package 'yarn'
