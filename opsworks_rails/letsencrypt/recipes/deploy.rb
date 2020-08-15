every_enabled_application do |application|
  email = node[:lets_encrypt_notification_email]
  domains = valid_domains_for(application).join(",")

  # Run certbot to setup TLS for the application.
  # We log the full command in the execute comment vs using a Chef::Log.info because Chef::Log.info
  # runs at time of parsing while the execute block is evaluated later, based on the runlist. The
  # Chef::Log.info statement will appear in the log far ahead of when the command is actually executed.
  certbot_command = "/root/nonblocking_certbot -m #{email} -d #{domains}"
  execute "Run Certbot: #{certbot_command}" do
    command certbot_command
    user "root"
  end
end
