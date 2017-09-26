class Messages::Base < ApplicationController
  before_action :set_message
  before_action :authorize!

  private

  def set_message
    @message = Message.find params[:message_id] || params[:id]
  end
end
