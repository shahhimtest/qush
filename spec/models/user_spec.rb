require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build :user }

  it { is_expected.to have_secure_password }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :confirmation_token }

  it { is_expected.to have_many(:messages).with_foreign_key(:publisher_id).dependent(:destroy) }
  it { is_expected.to have_many(:likes).dependent(:destroy) }

  it { is_expected.to have_many(:active_relationships).class_name('Relationship').with_foreign_key(:follower_id).dependent(:destroy) }
  it { is_expected.to have_many(:followed).through(:active_relationships).source(:followed) }
  it { is_expected.to have_many(:passive_relationships).class_name('Relationship').with_foreign_key(:followed_id).dependent(:destroy) }
  it { is_expected.to have_many(:follower).through(:passive_relationships).source(:follower) }

  it 'downcases email before save' do
    email = FFaker::Internet.email.upcase
    subject.email = email
    subject.save
    expect(subject.email).to eq email.downcase
  end

  describe 'confirmation token creation' do
    it 'creates a confirmation token if not provided on init' do
      subject = User.new
      expect(subject.confirmation_token).to_not be_nil
    end

    it 'creates no confirmation token of provided' do
      token = SecureRandom.urlsafe_base64
      subject = User.new confirmation_token: token
      expect(subject.confirmation_token).to eq token
    end

    it 'creates no new token for saved record' do
      token = SecureRandom.urlsafe_base64
      subject = FactoryGirl.create :user, confirmation_token: token
      subject.save
      record = User.find subject.id
      expect(record.confirmation_token).to eq subject.confirmation_token
    end
  end
end
