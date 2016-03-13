#!/usr/bin/env ruby

require 'pp'
require 'json'

`eval $(docker-machine env default)`

services = {}

%w( mysql memcached ).each do |name|
  container_id = `docker-compose ps -q #{name}`
  raw_info = `docker inspect #{container_id}`.chomp

  info = JSON.parse(raw_info).first

  info["NetworkSettings"]["Ports"].each do |key, value|
    port, protocol = key.split("/")
    
    service_info = {
      :service_port => port,
      :exposed_port => value.first["HostPort"],
      :protocol => protocol 
    }

    services[name] ||= Array.new 
    services[name] << service_info 
  end
end

pp services
