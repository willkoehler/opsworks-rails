module LEHelpers
  # App domains contains both the app short name (ex: ims) and domains configured
  # in the app (ex: ims.infoquestinv.com). Remove the non domain names.
  def valid_domains_for(app)
    app["domains"].select { |d| d.include?(".") }
  end
end

Chef::Recipe.send(:include, LEHelpers)
