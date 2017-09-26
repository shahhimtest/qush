require 'rails_helper'

RSpec.describe Message, type: :model do
  subject { build :message }

  it { is_expected.to belong_to(:publisher).class_name(:User) }

  it { is_expected.to validate_presence_of :content }
  it { is_expected.to validate_length_of(:content).is_at_most(180) }

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
end
