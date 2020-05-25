every_enabled_application do |application|
  email = node[:lets_encrypt_notification_email]
  domains = "-d " + valid_domains_for(application).join(" -d ")

  # Run certbot to setup TLS for the application
  execute "run certbot for #{domains}" do
    command "certbot --noninteractive --nginx --agree-tos --no-eff-email --redirect --keep-until-expiring -m #{email} #{domains}"
    user "root"
  end
end
