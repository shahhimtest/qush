FactoryGirl.define do
  factory :user do
    name { [FFaker::Name.first_name, FFaker::Name.last_name].join(' ') }
    username { FFaker::Internet.user_name }
    email { FFaker::Internet.email }
    password '123#Admin'
    confirmed true

    factory :unconfirmed_user do
      confirmed_at nil
    end
  end
end
