# frozen_string_literal: true

source "https://supermarket.chef.io"

cookbook "opsworks_ruby" # core Rails deploment cookbook
cookbook "packages" # allows OS packages to be installed
cookbook "deploy_resource", "= 1.0.2" # lock to 1.0.2 for compatibility with chef < 13
cookbook 'nodejs', '= 6.0.0' # lock to 6.0.0 for compatibility with chef < 13

# local cookbooks
cookbook "monitoring", path: "./monitoring"
cookbook "letsencrypt", path: "./letsencrypt"

metadata
