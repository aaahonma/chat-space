FactoryBot.define do
    factory :user do
        password = Faker::Internet.password(8)
        nickname              {Faker::Games::Pokemon.name}
        name                  {Faker::Movies::StarWars.character}
        email                 {Faker::Internet.free_email}
        icon_image            {File.open("#{Rails.root}/public/images/test_image.jpg")}
        introduction          {Faker::Games::Pokemon.move}
        password              {password}
        password_confirmation {password}
    end
end