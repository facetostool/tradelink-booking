class Api::V1::BookingSerializer
  include JSONAPI::Serializer

  attributes :username

  has_many :time_ranges
end