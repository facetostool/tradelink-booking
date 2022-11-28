class TimeRange
  class PopulateDay
    MINUTES_IN_DAY = 24*60.minutes.freeze

    class << self
      def call!(day)
        begging = day.beginning_of_day
        (MINUTES_IN_DAY/DEFAULT_TIME_RANGE).times do
          start_time = begging
          end_time = begging + DEFAULT_TIME_RANGE
          TimeRange.create!(
            date: begging,
            start_time: start_time,
            end_time: end_time,
          )
          begging = end_time
        end
      end
    end
  end
end