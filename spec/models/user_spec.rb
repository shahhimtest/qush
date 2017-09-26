require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build :user }

  it { is_expected.to have_secure_password }

  it { is_expected.to validate_presence_of :name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :confirmation_token }

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
