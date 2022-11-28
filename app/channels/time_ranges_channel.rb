class TimeRangesChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'time_ranges_channel'
  end

  def unsubscribed
  end
end