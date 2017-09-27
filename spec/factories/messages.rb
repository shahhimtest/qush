FactoryGirl.define do
  factory :message do
    association :publisher, factory: :user
    content { FFaker::HipsterIpsum.paragraph.truncate(140) }
  end
end
