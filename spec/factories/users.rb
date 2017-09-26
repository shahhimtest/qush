FactoryGirl.define do
  factory :user do
    name { [FFaker::Name.first_name, FFaker::Name.last_name].join(' ') }
    username { [FFaker::Internet.user_name, Random.rand(10_000)].join('_')[0,20] }
    email { FFaker::Internet.email }
    password '123#Admin'
    confirmed true

    factory :unconfirmed_user do
      confirmed_at nil
    end
  end
end
