module Creepermon
  class Site
    attr_reader :url, :xpath

    def initialize url, xpath
      @url = url
      @xpath = xpath
    end

    def scrape
      request = Typhoeus::Request.new(url, method: :get, followlocation: true)
      request.run

      response = request.response

      data = Nokogiri::HTML(response.body)
      value = 0.0
      if data && data.at_xpath(xpath)
        value = data.at_xpath(xpath).child.to_s.to_f
      end

      return {value: value, request_length: response.total_time, code: response.code}
    end
  end
end
