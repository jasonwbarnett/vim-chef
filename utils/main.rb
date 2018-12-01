#!/usr/bin/env ruby -I~/git/chef/lib/chef/lib
require 'chef'

resource_classes = Chef::Resource.descendants

resource_classes.each do |klass|
  resource_name = klass.resource_name
  allowed_actions = klass.allowed_actions

  properties = klass.properties.map { |x| x[1] }
  properties.reject! { |x| x.name == :name }

  resource_properties = properties.select { |x| x.declared_in == klass }.map { |x| x.name.to_s }
  other_properties    = properties.select { |x| x.declared_in != klass && x.declared_in != Chef::Resource }.map { |x| "#{x.name} (#{x.declared_in})" }
  common_properties   = properties.select { |x| x.declared_in == Chef::Resource }.map { |x| x.name.to_s }

  puts "Resource: #{klass.name}"
  puts "Resource Allowed Actions: #{allowed_actions}"
  puts "Resource Properties: #{resource_properties.join(', ')}"
  puts "Other Properties: #{other_properties.join(', ')}"
  puts "Common Properties: #{common_properties.join(', ')}"
  puts ""
end
