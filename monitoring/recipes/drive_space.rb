template "/srv/monitor_drive_space" do
  source "monitor_drive_space.erb"
  owner 'root'
  mode 0744
  variables(instance: search(:aws_opsworks_instance).first, stack: search(:aws_opsworks_stack).first)
end

cron "monitor_drive_space" do
  minute "*/5"
  command "/srv/monitor_drive_space"
  path "/usr/bin"
  user 'root'
end
