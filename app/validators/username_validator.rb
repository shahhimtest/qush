class UsernameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return unless value.present?
    unless value =~ /\A([a-z0-9\_]){2,20}\z/i
      record.errors[attribute] << (options[:message] || I18n.t('errors.messages.not_a_valid_username'))
    end
  end
end
