# Chef::Resource::User.send(:include, Helpers)
include Helpers

# valid_domains_for("a", "b", "c.d")

every_enabled_application do |application|
  email = node[:lets_encrypt_notification_email]
  domains = "-d " + valid_domains_for(application).join(" -d ")

  # Run certbot to setup TLS for the application
  execute "run certbot" do
    command "certbot --noninteractive --nginx --agree-tos --no-eff-email --redirect --keep-until-expiring -m #{email} #{domains}"
    user "root"
  end
end
