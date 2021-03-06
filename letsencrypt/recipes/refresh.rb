every_enabled_application do |application|
  email = node[:lets_encrypt_notification_email]

  # Use certbot_nonblocking if we have AWS credentials (which means we are using AWS Route 53 DNS)
  if File.exist?('/root/.aws/config')
    domains = valid_domains_for(application).join(",")
    certbot_command = "/root/certbot_nonblocking -m #{email} -d #{domains}"
  else
    domains = "-d " + valid_domains_for(application).join(" -d ")
    certbot_command = "certbot --noninteractive --nginx --agree-tos --no-eff-email --no-redirect --keep-until-expiring -m #{email} #{domains}"
  end

  # Run certbot to setup TLS for the application after nginx config has been created/changed
  execute "Run Certbot: #{certbot_command}" do
    command certbot_command
    user "root"
    action :nothing
    subscribes :run, "template[/etc/nginx/sites-available/#{application['shortname']}.conf]", :delayed
  end
end
