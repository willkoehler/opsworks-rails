apt_repository "certbot" do
  uri "ppa:certbot/certbot"
end

package("certbot") { action :install }
package("python3-certbot-nginx") { action :install }
