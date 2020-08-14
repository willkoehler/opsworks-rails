apt_repository "certbot" do
  uri "ppa:certbot/certbot"
end

package("certbot") { action :install }
package("python3-certbot-nginx") { action :install }

# Generate ~/.aws/config with AWS credentials if credentials are present in the config
directory "/root/.aws" do
  owner "root"
  group "root"
  only_if { node[:certbot_aws_access_key] }
end

template "/root/.aws/config" do
  source "config.erb"
  mode "400"
  owner "root"
  group "root"
  only_if { node[:certbot_aws_access_key] }
end
