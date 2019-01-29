class MessageController < ApplicationController
  def index
    @messages = Messages.where(recipient_id: current_user.id)
  end

  def new
    @message = Message.new
  end

  def create
    @user = User.find(params['id'])
    @message = current_user.message.build(user_id: params[current_user.id], recipient_id: params[@user.id])
    flash[:notice] = "Message sent"
    redirect_to associations_path
  end
end
