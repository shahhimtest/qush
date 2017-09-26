class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  strip_attributes

  def self.booleanable(field_name, datetime_field_name: [field_name, :_at].join)
    getter_name = field_name
    getter_name_2 = [field_name, :'?'].join
    setter_name = [field_name, :'='].join
    bang_setter_name = [field_name, :'!'].join

    define_method getter_name do
      val = read_attribute(datetime_field_name)
      val.present? && val.past?
    end
    alias_method getter_name_2, getter_name

    define_method setter_name do |val|
      if val == true || val == 'true' || val == '1'
        write_attribute(datetime_field_name, Time.current)
      elsif val == false || val == 'false' || val == '0'
        write_attribute(datetime_field_name, nil)
      end
    end

    define_method bang_setter_name do
      return false if public_send(getter_name)
      write_attribute(datetime_field_name, Time.current)
    end
  end
end
