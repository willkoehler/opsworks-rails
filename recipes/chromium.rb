# From https://gist.github.com/pragmaticivan/cff18a70dba1fa8db8cb92e42dee82c9
apt_repository 'ffmpeg' do
  uri 'ppa:canonical-chromium-builds/stage'
end

package %w(software-properties-common chromium-browser) do
  action :install
end
