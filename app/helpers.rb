module CreeperMon
  module Helpers
    def title
      if !@title.nil? && !@title.empty?
        "| #{@title}"
      else
        ""
      end
    end
  end
end

CreeperMon::App.helpers CreeperMon::Helpers
