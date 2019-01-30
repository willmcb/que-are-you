class MessagesController < ApplicationController

  def index
    @users = User.all
    @messages = Message.where(associate_id: current_user.id)
  end

  def new
    @associate = User.find(params[:id])
    @message = Message.new
  end

  def create
    @params = message_params
    @user = current_user
    @associate_id = @params[:associate_id]
    @message = @user.messages.create(user_id: @user.id, associate_id: @associate_id, content: @params[:content])
    if @message.save
      redirect_to messages_path
      flash[:notice] = "Message sent"
    else
      render 'new'
    end
  end

  private

  def message_params
      params.require(:message).permit(:content, :associate_id)
    end
end
