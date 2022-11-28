class TimeRange < ActiveRecord::Base
  DEFAULT_TIME_RANGE = 15.minutes

  belongs_to :booking, optional: true

  validates :date, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true

  scope :by_date, ->(date) { where(date: date) }

  def in_future?
    Time.now > start_time
  end

  def free?
    booking_id == nil
  end
end