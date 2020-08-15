#!/usr/bin/ruby

require "optparse"
require "pty"

params = {}
OptionParser.new { |opts|
  opts.on("-d VAL", Array)
  opts.on("-m VAL", String)
}.parse!(into: params)

# When certbot is run with a wildcard cert, we get a prompt from certbot and there's
# no way to automate it:
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
# This code waits for that response and picks the appropriate server block
# NOTE: Because of this, we can't use the "--noninteractive" parameter
domain_params = "-d " + params[:d].join(" -d ")
certbot_command = "certbot -a dns-route53 -i nginx --agree-tos --no-eff-email --no-redirect --keep-until-expiring -m #{params[:m]} #{domain_params}"
puts "EXECUTING: #{certbot_command}"

PTY.spawn(certbot_command) do |stdout, stdin, pid|
  response = ""
  begin
    # Read response until we get the "Select the appropriate numbers" prompt or
    # until Errno::EIO is raised (indicating that there wasn't a prompt)
    response << stdout.sysread(512) until response.include?("(Enter 'c' to cancel)")
    # Figure out which server block to select
    nginx_config_filename = response.match(/Deploying Certificate to VirtualHost (.*conf)/)[1]
    option = response.match(/(\d):.*#{Regexp.escape(nginx_config_filename)}/)[1]
    puts "CHOOSING OPTION: " + option
    # select the server block
    stdin.puts option
    # read the remainder of the response (until Errno::EIO is raised)
    stdout.each { |line| response << line }
  rescue Errno::EIO
    # This execption is raised at the end of the command's output
    puts response
    puts "\nCOMMAND COMPLETED"
  end
end
