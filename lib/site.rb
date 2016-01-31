module Creepermon
  class Site
    attr_reader :url, :xpath

    def initialize url, xpath
      @url = url
      @xpath = xpath
    end

    def scrape
      request = Typhoeus::Request.new(url, method: :get)
      request.run

      response = request.response
      time = response.total_time

      data = Nokogiri::HTML(response.body)
      value = data.at_xpath(xpath).child.to_s.to_f

      return {value: value, time: time}
    end
  end
end
