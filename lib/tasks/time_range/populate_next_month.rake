namespace :time_range do
  task :populate_next_month => [ :environment ] do
    TimeRange::PopulateMonth.call!(Date.today)
  end
end