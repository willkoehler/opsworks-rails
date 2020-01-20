# frozen_string_literal: true
source 'https://supermarket.chef.io'

cookbook 'opsworks_ruby'          # core Rails deploment cookbook
cookbook 'packages'               # allows OS packages to be installed
cookbook 'sudo', '= 5.4.4'        # lock to 5.4.4 for compatibility with chef < 12.21.3
cookbook 'ark', '= 4.0.0'         # lock to 4.0.0 for compatibility with chef < 14

# local cookbooks
cookbook "monitoring", path: "./monitoring"

metadata
