# From https://github.com/ajgon/opsworks_ruby/blob/master/libraries/helpers.rb
# frozen_string_literal: true

module Helpers
  # def applications
  #   Chef::Log.warn("This recipe uses search. Chef Solo does not support search.") if Chef::Config[:solo]
  #   search(:aws_opsworks_app)
  # end

  # def every_enabled_application
  #   node["deploy"].each_key do |deploy_app_shortname|
  #     application = applications.detect { |app| app["shortname"] == deploy_app_shortname }
  #     next unless application && application["deploy"]

  #     yield application
  #   end
  # end

  # App domains contains both the app short name (ex: ims) and domains configured
  # in the app (ex: ims.infoquestinv.com). Remove the non domain names.
  def valid_domains_for(app)
    app["domains"].filter { |d| d.include?(".") }
  end
end

Chef::Recipe.send(:include, HelpersX)
