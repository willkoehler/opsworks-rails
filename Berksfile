# frozen_string_literal: true

source "https://supermarket.chef.io"

# Use fork until https://github.com/ajgon/opsworks_ruby/pull/252 is merged
cookbook "opsworks_ruby", git: "https://github.com/kzkn/opsworks_ruby.git", branch: "fix-251"
# cookbook "opsworks_ruby", "=1.20.0" # core Rails deploment cookbook

cookbook "packages" # allows OS packages to be installed
cookbook "deploy_resource", "= 1.0.2" # lock to 1.0.2 for compatibility with chef < 13

# local cookbooks
cookbook "monitoring", path: "./monitoring"
cookbook "letsencrypt", path: "./letsencrypt"

metadata
