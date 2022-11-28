class Booking < ActiveRecord::Base
  has_many :time_ranges

  validates :username, presence: true
end