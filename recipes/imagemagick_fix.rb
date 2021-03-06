# Allow ImageMagick to read PDFs. See https://stackoverflow.com/a/52661288/935514
# ...also allow ImageMagick to read from HTTPS

PolicyFile = "/etc/ImageMagick-6/policy.xml"
UnauthorizedPolicy1 = '<policy domain="coder" rights="none" pattern="PDF" />'
AuthorizedPolicy1 = '  <policy domain="coder" rights="read" pattern="PDF" />'
UnauthorizedPolicy2 = '<policy domain="delegate" rights="none" pattern="HTTPS" />'
AuthorizedPolicy2 = '  <policy domain="delegate" rights="*" pattern="HTTPS" />'
# '*' isn't documented anywhere, but makes things work
# convert "https://ims-assets.s3.amazonaws.com/documents/8/wagon.jpg" test.jpg was returning a
# "not authorized `HTTPS' @ error/delegate.c/InvokeDelegate/1717." error. With the '*' it works.

ruby_block "Allow ImageMagick to read PDF files" do
  block do
    file = Chef::Util::FileEdit.new(PolicyFile)
    file.search_file_replace_line(UnauthorizedPolicy1, AuthorizedPolicy1)
    file.search_file_replace_line(UnauthorizedPolicy2, AuthorizedPolicy2)
    file.write_file
  end
end
