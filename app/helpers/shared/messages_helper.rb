module Shared::MessagesHelper
  def message_type?(type)
    type = type.to_s
    
    type == 'success' || \
    type == 'info' || \
    type == 'warning' || \
    type == 'danger'
  end
end
