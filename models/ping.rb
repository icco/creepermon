class Ping < ActiveRecord::Base
  validates :site, :url => true

  def self.factory url
    require 'net/http'
    require 'uri'

    begin
      start_time = Time.now
      response = Net::HTTP.get_response(URI.parse(url))
    rescue Errno::ETIMEDOUT
      puts "Timeout, #{url}"
    rescue Errno::ECONNREFUSED
      puts "Refused, #{url}"
    rescue SocketError
      puts "Error, #{url}"
    end 

    end_time = Time.now - start_time

    i = Ping.new
    i.site = url
    i.code = response
    i.time = end_time
    i.save
    
    return i
  end
end
