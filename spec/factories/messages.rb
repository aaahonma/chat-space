FactoryBot.define do
    factory :message do
      content     {Faker::Lorem.sentence}
      image       {File.open("#{Rails.root}/public/images/test_image.jpg")}  # 画像データはFakerでは生成不可。File.openで参照
      user
      group
    end
  end
