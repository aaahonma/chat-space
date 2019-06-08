FactoryBot.define do
    factory :group do
      name {Faker::Music::RockBand.name}
    end
end