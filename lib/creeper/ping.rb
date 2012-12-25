module Creeper
  class Ping < Struct.new(:url)
    def run
      query = Typhoeus.get(self.url, followlocation: true)

      return query
    end
  end
end
