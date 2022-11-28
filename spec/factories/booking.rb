FactoryBot.define do
  factory :booking do
    username { Faker::FunnyName.name }
  end
end