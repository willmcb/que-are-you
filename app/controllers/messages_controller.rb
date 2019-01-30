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
    @message = @user.messages.create(user_id: @user.id, associate_id: @associate_id, sender_id: @user.id, content: @params[:content])
    @opp_message = opposite_message(@associate_id, current_user.id, current_user.id, @params[:content])
    if @message.save && @opp_message.save
      redirect_to messages_path
      flash[:notice] = "Message sent"
    else
      render 'new'
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    flash[:notice] = "Business card removed"
    redirect_to messages_path
  end

  private

  def message_params
      params.require(:message).permit(:content, :associate_id)
  end


  def opposite_message(associate_id, current_user_id, sender_id, content)
    User.find(associate_id).messages.create(user_id: associate_id, associate_id: current_user_id, sender_id: sender_id, content: content)
  end
end
