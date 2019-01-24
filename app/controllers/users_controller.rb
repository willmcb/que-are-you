class UsersController < ApplicationController

  before_action :authorize, only: [:index, :show, :edit, :update]

  def new
    @user = User.new
  end

  def index
    @user = current_user
    @qr = encode
  end

  def show
    @user = User.find(params['id'])
  end

  def create
    @user = User.new(user_params)

    @user.email.downcase!

    if @user.save
      redirect_to root_path
      session[:user_id] = @user.id.to_s
      flash[:notice] = "Account created successfully!"
    else
      flash.now.alert = "Oops, couldn't create account. Please make sure you are using a valid email and password and try again."
      render :new
    end
  end

  def edit
    @user = User.find(params['id'])
  end

  def update
    @user_id = update_user_params[:id]
    User.find(@user_id).update(update_user_params)
    redirect_to user_profile_path(@user_id)
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
  end

  def update_user_params
    params.permit(:id, :firstname, :lastname, :email, :job_title, :company_name, :biography, :avatar)
  end

  def encode
    RQRCode::QRCode.new(session[:user_id].to_s)
  end

end
