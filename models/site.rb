class Site
  attr_reader :url

  def initialize url
    @url = url
  end

  def domain
    require 'uri'
    URI(self.url).host
  end

  def most_recent_fail
    return Ping.where(:site => self.url).where("code != 200").limit(1).order("created_at DESC").first
  end

  def most_recent_success
    return Ping.where(:site => self.url).where("code = 200").limit(1).order("created_at DESC").first
  end
end
