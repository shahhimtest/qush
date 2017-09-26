class Message < ApplicationRecord
  belongs_to :publisher, class_name: :User

  validates :content, presence: true, length: { maximum: 180 }

  validate :if_url_in_content

  has_many :likes

  private

  def if_url_in_content
    return unless content.present?

    regex = /[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/

    if content.match regex
      errors.add :content, I18n.t('errors.messages.contains_url')
    end
  end
end
