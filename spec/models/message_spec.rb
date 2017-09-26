require 'rails_helper'

RSpec.describe Message, type: :model do
  subject { build :message }

  it { is_expected.to belong_to(:publisher).class_name(:User) }

  it { is_expected.to validate_presence_of :content }
  it { is_expected.to validate_length_of(:content).is_at_most(180) }

  it { is_expected.to have_many(:likes).dependent(:destroy) }

  describe 'url in content' do
    context 'with url' do
      before { subject.content = 'hipster ipsum abc.com' }

      it { is_expected.to be_invalid }

      it 'adds error' do
        subject.validate
        expect(subject.errors.messages[:content]).to include(I18n.t('errors.messages.contains_url'))
      end
    end
  end

  describe 'validate if user can publish' do
    context 'user can publish' do
      before { allow(subject.publisher).to receive(:can_publish?) { true } }
      it { is_expected.to be_valid }
    end

    context 'user cannot publish' do
      before { allow(subject.publisher).to receive(:can_publish?) { false } }

      it { is_expected.to be_invalid }

      it 'sets error' do
        subject.validate
        expect(subject.errors.messages[:publisher]).to include(I18n.t('errors.messages.cannot_publish'))
      end
    end
  end
end
