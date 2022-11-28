require 'rails_helper'

RSpec.describe TimeRange::PopulateMonth, type: :service do
  subject { described_class }

  let(:freeze_time) { Time.utc(2022, 2, 10, 0, 0, 0) }

  describe '#call!' do
    around do |example|
      Timecop.freeze(freeze_time) do
        example.run
      end
    end

    before { allow(TimeRange::PopulateDay).to receive(:call!) }

    it 'create 96 time ranges with a right format' do
      subject.call!(Date.today)
      expect(TimeRange::PopulateDay).to have_received(:call!).exactly(Date.today.end_of_month.day).times
    end
  end
end