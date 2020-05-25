every_enabled_application do |application|
  email = node[:lets_encrypt_notification_email]
  domains = "-d " + valid_domains_for(application).join(" -d ")

  # Run certbot to setup TLS for the application
  certbot_command = "certbot --noninteractive --nginx --agree-tos --no-eff-email --redirect --keep-until-expiring -m #{email} #{domains}"
  Chef::Log.info("Running Certbot: #{certbot_command}")

  execute "run certbot" do
    command certbot_command
    user "root"
  end
end
