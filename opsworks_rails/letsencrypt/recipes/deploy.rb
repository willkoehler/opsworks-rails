every_enabled_application do |application|
  email = node[:lets_encrypt_notification_email]
  domains = "-d " + valid_domains_for(application).join(" -d ")

  # Run certbot to setup TLS for the application.
  # We log the full command in the execute comment vs using a Chef::Log.info because Chef::Log.info
  # runs at time of parsing while the execute block is evaluated later, based on the runlist. The
  # Chef::Log.info statement will appear in the log far ahead of when the command is actually executed.
  #
  # The "echo | " sends a <return> (\n) to the command. This is needed when we have a wildcard cert
  # because we get a prompt from certbot and there's no way to automate it.
  #
  # Which server blocks would you like to modify?
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # 1: File: /etc/nginx/sites-enabled/chronicle.conf
  # Addresses: 443 ssl
  # Names: rails1, *.cmscontracts.com, cmscontracts.com, chronicle
  # HTTPS: Yes

  # 2: File: /etc/nginx/sites-enabled/signyl_for_rehab.conf
  # Addresses: 443 ssl
  # Names: rails1, rehab.psiapps.com, signyl_for_rehab
  # HTTPS: Yes

  # 3: File: /etc/nginx/sites-enabled/signyl_for_supply_chain.conf
  # Addresses: 443 ssl
  # Names: signyl.psiapps.com, rails1, signyl_for_supply_chain
  # HTTPS: Yes
  # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  # Select the appropriate numbers separated by commas and/or spaces, or leave input
  # blank to select all options shown (Enter 'c' to cancel):
  #
  # NOTE: Because of this, we can't use the "--noninteractive" parameter

  certbot_command = "echo | certbot -a dns-route53 -i nginx --agree-tos --no-eff-email --no-redirect --keep-until-expiring -m #{email} #{domains}"
  execute "Run Certbot: #{certbot_command}" do
    command certbot_command
    user "root"
  end
end
