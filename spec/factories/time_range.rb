FactoryBot.define do
  factory :time_range do
    date { Faker::Date.between(from: Date.today, to: 7.days.after) }
    start_time  { date.to_datetime }
    end_time { date.to_datetime + TimeRange::DEFAULT_TIME_RANGE }
  end
end