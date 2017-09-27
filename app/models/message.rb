class Message < ApplicationRecord
  belongs_to :publisher, class_name: :User

  validates :content, presence: true, length: { maximum: 140 }

  validate :if_url_in_content
  validate :if_user_can_publish

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  scope :created_last_24_hours, -> { where("created_at >= ?", 1.day.ago) }

  private

  def if_url_in_content
    return unless content.present?

    regex = /[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/

    if content.match regex
      errors.add :content, I18n.t('errors.messages.contains_url')
    end
  end

  def if_user_can_publish
    unless publisher.can_publish?
      errors.add :publisher, I18n.t('errors.messages.cannot_publish')
    end
  end
end
