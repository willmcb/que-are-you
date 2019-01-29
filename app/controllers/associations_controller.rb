require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'

class AssociationsController < ApplicationController

  def index
    @associations = Association.where(user_id: current_user.id)
  end

  def new
    @association = Association.new
  end

  def create
    get_events
    if current_user.id == params[:associate_id].to_i
        flash[:notice] = "You can't add your own profile."
        redirect_to associations_path
    elsif already_associates?(params[:associate_id])
      flash[:notice] = "You are already associates."
      redirect_to associations_path
    else
      @association = current_user.associations.build(:associate_id => params[:associate_id])
      @opp_association = opposite_association(params[:associate_id], current_user.id)
      if @association.save || @opp_association.save
        flash[:notice] = "Added associate."
        redirect_to associations_path
      else
        flash[:notice] = "Unable to add associate."
        redirect_to root_url
      end
    end
  end

  def destroy
    @association = current_user.associations.find(params[:id])
    @association.destroy
    flash[:notice] = "Business card removed"
    redirect_to associations_path
  end

  def get_events
    p 'start'
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
  puts 'Upcoming events:'
  puts 'No upcoming events found' if response.items.empty?
  response.items.each do |event|
    start = event.start.date || event.start.date_time
    puts "- #{event.summary} (#{start})"
  end
end

  private

  def opposite_association(associate_id, current_user_id)
    User.find(associate_id).associations.build(associate_id: current_user_id)
  end

  def already_associates?(associates_id)
    user_has_associate = current_user.associations.map do |association|
      association.associate_id
    end.include?(associates_id.to_i)
  end

  def google_secret
    p "user:"
    p current_user
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
