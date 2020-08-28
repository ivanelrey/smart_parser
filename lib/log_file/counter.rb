require 'set'

module LogFile
  class Counter
    attr_reader :visits_per_web_page

    def initialize
      @visits_per_web_page = Hash.new { |h, k| h[k] = { ip_list: Set.new, total_visits: 0 } }
    end

    def add_web_page_visit(web_page_string, ip_string)
      web_page_visit = visits_per_web_page[web_page_string]

      web_page_visit[:ip_list].add(ip_string)
      web_page_visit[:total_visits] += 1
    end
  end
end
