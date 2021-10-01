# Fixes Error running Setup. See https://github.com/ajgon/opsworks_ruby/issues/268
#
# ================================================================================
# Error executing action `create` on resource 'remote_file[/var/chef/runs/e01650a1-9df0-4440-9cee-afa45695d345/local-mode-cache/cache/https___nginx_org_keys_nginx_signing_key]'
# ================================================================================
#
# OpenSSL::SSL::SSLError
# ----------------------
# SSL Error connecting to https://nginx.org/keys/nginx_signing.key - SSL_connect returned=1 errno=0 state=error: certificate verify failed
#
# Resource Declaration:
# ---------------------
# # In /opt/chef/embedded/lib/ruby/gems/2.3.0/gems/chef-12.22.5/lib/chef/provider/apt_repository.rb
#
# 171:         declare_resource(type, cached_keyfile) do
# 172:           source new_resource.key
# 173:           mode "0644"
# 174:           sensitive new_resource.sensitive
# 175:           action :create
# 176:         end
# 177:
#
# Compiled Resource:
# ------------------
# # Declared in /opt/chef/embedded/lib/ruby/gems/2.3.0/gems/chef-12.22.5/lib/chef/provider/apt_repository.rb:171:in `install_key_from_uri'
#
# remote_file("/var/chef/runs/e01650a1-9df0-4440-9cee-afa45695d345/local-mode-cache/cache/https___nginx_org_keys_nginx_signing_key") do
# provider Chef::Provider::RemoteFile
# action [:create]
# retries 0
# retry_delay 2
# default_guard_interpreter :default
# source ["https://nginx.org/keys/nginx_signing.key"]
# use_etag true
# use_last_modified true
# declared_type :remote_file
# cookbook_name "nginx"
# path "/var/chef/runs/e01650a1-9df0-4440-9cee-afa45695d345/local-mode-cache/cache/https___nginx_org_keys_nginx_signing_key"
# owner nil
# group nil
# checksum nil
# verifications []
# mode "0644"
# end
#
# System Info:
# ------------
# chef_version=12.22.5
# platform=ubuntu
# platform_version=18.04
# ruby=ruby 2.3.6p384 (2017-12-14 revision 61254) [x86_64-linux]
# program_name=chef-client worker: ppid=17821;start=12:52:40;
# executable=/opt/chef/bin/chef-client

link '/opt/chef/embedded/ssl/certs/cacert.pem' do
  to '/etc/ssl/certs/ca-certificates.crt'
end
