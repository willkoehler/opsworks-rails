package 'unzip' do
  action :install
end

bash "Setup Raygun APM Service" do
  user "root"
  cwd "/tmp"
  code <<~EOH
    mkdir /opt/raygun
    wget -q https://downloads.raygun.com/APM/latest/RaygunAgent-netcore-linux.zip
    unzip -q -d /opt/raygun/agent -o RaygunAgent-netcore-linux.zip
    rm RaygunAgent-netcore-linux.zip
    chmod +x /opt/raygun/agent/RaygunAgent
    chmod +x /opt/raygun/agent/rgc
    mv /opt/raygun/agent/raygunagent.service /etc/systemd/system/
    systemctl daemon-reload
  EOH
  not_if { File.exist?("/etc/systemd/system/raygunagent.service") }
end

service "raygunagent" do
  action :start
end

execute "Set Raygun API key" do
  command "/opt/raygun/agent/rgc -register #{node[:raygun_api_key]}"
  user "root"
  action :nothing
  subscribes :run, "service[raygunagent]", :immediate
end

