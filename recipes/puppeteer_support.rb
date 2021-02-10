# These are packages needed on Ubuntu 18.04 for Puppeteer. Puppeteer will automatically
# install the needed version of Chromium.
# From https://github.com/puppeteer/puppeteer/issues/3443#issuecomment-433096772
# Also see https://github.com/actions/virtual-environments/issues/732#issuecomment-614809415
package %w(
  fonts-noto-color-emoji
  libappindicator1
  libasound2
  libatk1.0-0
  libcairo2
  libcups2
  libdbus-1-3
  libexpat1
  libfontconfig1
  libgconf-2-4
  libgdk-pixbuf2.0-0
  libglib2.0-0
  libgtk-3-0
  libgbm-dev
  libnspr4
  libnss3
  libpango-1.0-0
  libpangocairo-1.0-0
  libx11-6
  libx11-xcb1
  libxcb1
  libxcomposite1
  libxcursor1
  libxdamage1
  libxext6
  libxfixes3
  libxi6
  libxrandr2
  libxrender1
  libxss1
  libxtst6
  ca-certificates
  fonts-liberation
  gconf-service
  lsb-release
  wget
  xdg-utils
) do
  action :install
end
