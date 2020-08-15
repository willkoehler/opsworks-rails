apt_repository "certbot" do
  uri "ppa:certbot/certbot"
end

package("certbot") { action :install }
package("python3-certbot-nginx") { action :install }
package("python3-certbot-dns-route53") { action :install }

template "/root/certbot_nonblocking" do
  source "certbot_nonblocking.rb"
  mode "700"
  owner "root"
  group "root"
end

# Generate ~/.aws/config with AWS credentials if credentials are present in the config
directory "/root/.aws" do
  owner "root"
  group "root"
  only_if { node[:certbot_aws_access_key] }
end

# Generate ~/.aws/config with AWS credentials if credentials are present in the config
template "/root/.aws/config" do
  source "config.erb"
  mode "400"
  owner "root"
  group "root"
  only_if { node[:certbot_aws_access_key] }
end
