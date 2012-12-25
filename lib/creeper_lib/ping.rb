module CreeperLib
  class Ping
    attr_accessor :url

    def run
      query = Typhoeus.get(self.url, followlocation: true)

      return query
    end
  end
end
