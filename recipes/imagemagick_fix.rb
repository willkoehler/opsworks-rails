# Allow ImageMagick to read PDFs. See https://stackoverflow.com/a/52661288/935514

PolicyFile = "/etc/ImageMagick-6/policy.xml"
UnauthorizedPolicy = '<policy domain="coder" rights="none" pattern="PDF" />'
AuthorizedPolicy = '  <policy domain="coder" rights="read" pattern="PDF" />'

ruby_block "Allow ImageMagick to read PDF files" do
  block do
    file = Chef::Util::FileEdit.new(PolicyFile)
    file.search_file_replace_line(UnauthorizedPolicy, AuthorizedPolicy)
    file.write_file
  end
end