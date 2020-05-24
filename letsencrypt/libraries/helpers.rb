# From https://github.com/ajgon/opsworks_ruby/blob/master/libraries/helpers.rb
# frozen_string_literal: true

module Helpers
  def applications
    Chef::Log.warn("This recipe uses search. Chef Solo does not support search.") if Chef::Config[:solo]
    search(:aws_opsworks_app)
  end

  def every_enabled_application
    node["deploy"].each_key do |deploy_app_shortname|
      application = applications.detect { |app| app["shortname"] == deploy_app_shortname }
      next unless application && application["deploy"]

      yield application
    end
  end
end
