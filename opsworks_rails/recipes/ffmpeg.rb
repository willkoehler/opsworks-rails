# Ubuntu 16.04 only has FFMPEG 2.8.x in the official respositories.
# We need to add a new PPA for FFMPEG 4.x

apt_repository 'ffmpeg' do
  uri 'ppa:jonathonf/ffmpeg-4'
end

package 'ffmpeg' do
  action :install
end
