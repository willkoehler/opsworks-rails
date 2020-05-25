every_enabled_application do |application|
  email = node[:lets_encrypt_notification_email]
  domains = "-d " + valid_domains_for(application).join(" -d ")

  # Sleep to allow opsworks_ruby::deploy to finish updating Nginx config. Super hacky, but don't see any other way
  # to wait for opsworks_ruby::deploy to finish. If we don't wait there's a race condition between the Nginx config
  # change made by our deploy and certbot
  chef_sleep "Wait for Nginx config to be updated..." do
    seconds 5
  end

  # Run certbot to setup TLS for the application
  certbot_command = "certbot --noninteractive --nginx --agree-tos --no-eff-email --no-redirect --keep-until-expiring -m #{email} #{domains}"
  Chef::Log.info("Running Certbot: #{certbot_command}")

  execute "run certbot" do
    command certbot_command
    user "root"
  end
end
