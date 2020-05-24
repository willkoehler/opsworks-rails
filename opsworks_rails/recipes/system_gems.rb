# Install system gems (globally available).
# Specify gems with Stack JSON:
#
# "system_gems": {
#     "aws-sdk-cloudwatch": "1.13.0",
#     "sys-filesystem": "1.1.9"
# }

node[:system_gems].each do |gem_name, version|
  Chef::Log.info("Installing System Gem #{gem_name}")
  gem_package gem_name do
    version(version)
    retries 2
    options '--no-ri --no-rdoc'
  end
end
