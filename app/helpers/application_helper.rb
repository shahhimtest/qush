module ApplicationHelper
  def meta_tag(name, content, key_name: :name, value_name: :content)
    tag :meta, key_name => name, value_name => content
  end
end
