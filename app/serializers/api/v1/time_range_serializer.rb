class Api::V1::TimeRangeSerializer
  include JSONAPI::Serializer

  attributes :booking_id, :date, :start_time, :end_time
end