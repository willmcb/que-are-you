require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'

class UsersController < ApplicationController

  before_action :logged_in?, only: [:index, :show, :edit, :update]

  def new
    @user = User.new
  end

  def index
    @user = current_user
    @qr = encode
  end

  def show
    @user = User.find(params['id'])
    if current_user.id != @user.id
      @association = current_user.associations.find_by(associate_id: @user.id)
      @lat  = @association.latitude
      @long = @association.longitude
    end
  end

  def create
    @user = User.new(user_params)
    @user.avatar.attach(io: File.open(Rails.root.join(
      'public', 'Default_profile_image.jpg')), filename: 'Default_profile_image.jpg', content_type: 'image/jpg')
    @user.email.downcase!

    if @user.save
      redirect_to edit_profile_path(@user.id)
      session[:user_id] = @user.id.to_s
      flash[:notice] = "Account created successfully!"
    else
      flash.now.alert = "Oops, couldn't create account. Please make sure you are using a valid email and password and try again."
      render :new
    end
  end

  def edit
    @user = User.find(params['id'])
    authorize_edit_profile
  end

  def update
    @user_id = update_user_params[:id]
    User.find(@user_id).update(update_user_params)
    redirect_to user_profile_path(@user_id)
  end

  def event
    @user = current_user
    @events = get_events if @user.google_token != nil
    render :event
  end

  def update_event
    @user_id = update_event_params[:id]
    User.find(@user_id).update(update_event_params)
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:firstname, :lastname, :email, :password, :password_confirmation)
  end

  def update_user_params
    params.permit(:id, :firstname, :lastname, :email, :job_title, :company_name, :biography, :avatar, :event, :other_event)
  end

  def update_event_params
    params[:event] = params[:other_event] if params[:event] == "Other"
    params.permit(:id, :event)
  end

  def encode
    RQRCode::QRCode.new(session[:user_id].to_s)
  end

  def get_events
    # Initialize Google Calendar API
    service = Google::Apis::CalendarV3::CalendarService.new
    # Use google keys to authorize
    service.authorization = google_secret.to_authorization
    # Request for a new aceess token just incase it expired
    service.authorization.refresh!
    # Get a list of events
    calendar_id = 'primary'
    start_date = Date.today.rfc3339
    end_date = (Date.today + 1).rfc3339
    response = service.list_events(calendar_id,
                                single_events: true,
                                order_by: 'startTime',
                                time_min: start_date,
                                time_max: end_date
                              )
    # @events << 'No events found' if response.items.empty?
    @events = []
    response.items.each do |event|
      if event.attendees != nil
        event.attendees.each do |attendee|
          if attendee.email == current_user.email && attendee.response_status != "declined"
            @events << "#{event.summary}"
          end
        end
      else
        @events << "#{event.summary}"
      end
    end
    @events << "Other"
  end

  def google_secret
    Google::APIClient::ClientSecrets.new(
      { "web" =>
        { "access_token" => current_user.google_token,
          "refresh_token" => current_user.google_refresh_token,
          "client_id" => ENV['GOOGLE_CLIENT_ID'],
          "client_secret" => ENV['GOOGLE_CLIENT_SECRET']
        }
      }
    )
  end

end
