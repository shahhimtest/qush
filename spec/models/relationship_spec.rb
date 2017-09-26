require 'rails_helper'

RSpec.describe Relationship, type: :model do
  subject { build :relationship }

  it { is_expected.to be_valid }

  it { is_expected.to belong_to(:follower).class_name(:User) }
  it { is_expected.to belong_to(:followed).class_name(:User) }

  it 'is invalid if same user follows other user already' do
    subject.save
    duplicate = build :relationship, follower: subject.follower, followed: subject.followed
    expect(duplicate).to be_invalid
  end
end
