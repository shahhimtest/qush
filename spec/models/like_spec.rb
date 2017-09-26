require 'rails_helper'

RSpec.describe Like, type: :model do
  subject { build :like }

  it { is_expected.to belong_to(:message).counter_cache(true) }
  it { is_expected.to belong_to :user }

  it 'is invalid if same user liked message already' do
    subject.save
    duplicate = build :like, message: subject.message, user: subject.user
    expect(duplicate).to be_invalid
  end
end
