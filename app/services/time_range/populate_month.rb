class TimeRange
  class PopulateMonth
    class << self
      def call!(start_date)
        start_date.step(start_date.next_month - 1.day).each do |day|
          PopulateDay.call!(day)
        end
      end
    end
  end
end