module LogFile
  module Presenters
    class CounterPresenter
      def initialize(counter)
        @counter = counter
      end

      def most_visited_pages
        total_visits = @counter.visits_per_web_page.map { |key, value| [key, value.fetch(:total_visits)] }
        sort_array(total_visits)
      end

      def most_uniq_visited_pages
        uniq_visits = @counter.visits_per_web_page.map { |key, value| [key, value.fetch(:ip_list).count] }
        sort_array(uniq_visits)
      end

      private

      def sort_array(array)
        array.sort_by { |_x, y| -y }
      end
    end
  end
end
