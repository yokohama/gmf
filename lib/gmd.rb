#coding: utf-8
require 'csv'

module Railstar

  class GMD
    def self.csv2issues(file)
      issues = []
      CSV.open(file, "r").each_with_index do |col, i|
        issues << {large:col[0], middle:col[1], smale:col[2], body:col[3]} unless i == 0
      end
      larges = []
      issues.group_by{|v| v[:large] }.keys.each_with_index do |k, i| 
        larges << Large.new(title:k, section:i)
      end
      larges.each do |l|
        #issues.select{|i| i[:middle].nil? && i[:smale].nil? && i[:large] == l.title }.each{|v| l.body = v[:body] }
        issues.select{|i| i[:smale].nil? && i[:large] == l.title }.each_with_index{|v,i| l.children << Middle.new(section:"#{l.section}-#{i}", title:v[:middle], body:v[:body]) }
        l.children.each do |m|
          issues.select{|i| i[:smale] && i[:middle] == m.title }.each_with_index{|v,i| m.children << Smale.new(section:"#{m.section}-#{i}", title:v[:smale], body:v[:body]) }
        end
      end
      #larges.each {|l| l.tree }
      larges
    end

    class Issue
      attr_accessor :section, :title, :body, :children
  
      def initialize(options={})
        @section = options[:section]
        @title = options[:title]
        @body = options[:body]
        @children = options[:children] || []
      end
  
      def tree(prefix='|-')
        p "#{prefix} #{@title}"
        p "==== #{@body}" if @body
        @children.each {|c| c.tree("#{prefix}-") }
      end
    end
  
    class Large  < Issue; end;
    class Middle < Issue; end;
    class Smale  < Issue; end;
  end

end
