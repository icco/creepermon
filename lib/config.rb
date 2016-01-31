module Creepermon
  class Config
    attr_reader :sites

    def initialize
      @sites = []
    end

    def add_site site
      raise "No url to scrape in #{site.inspect}" unless site["url"]
      site["xpath"] ||= ""

      @sites.push(Site.new(site["url"], site["xpath"]))
    end

    def self.load_config filename="sites.yml"
      data = File.read filename
      parsed = YAML.load(data)
      config = Config.new
      parsed["sites"].each do |s|
        config.add_site s
      end

      return config
    end
  end
end
