require "erb"
require File.expand_path(File.dirname(__FILE__) + '/../lib/gmd.rb')

issues = Railstar::GMD.csv2issues ARGV[0]
puts ERB.new(DATA.read, nil, '-', '_erbout').run(binding)

__END__
## Table of Contents
<%- issues.each do |i| -%>
* [<%= i.title %>](#section-<%= i.section %>)
  <%- i.children.each do |m| -%>
  * [<%= m.title %>](#section-<%= m.section %>)
    <%- m.children.each do |s| -%>
      * [<%= s.title %>](#section-<%= s.section %>)
    <%- end -%>
  <%- end -%>
<%- end -%>

<%- issues.each do |i| -%>
##### section-<%= i.section %>
## <%= i.title %>
  <%- i.children.each do |m| -%>
##### section-<%= m.section %>
### <%= m.title %>
<%= m.body %>
    <%- m.children.each do |s| -%>
##### section-<%= s.section %>
#### <%= s.title %>
<%= s.body %>

    <%- end -%>

  <%- end -%>

<%- end -%>
