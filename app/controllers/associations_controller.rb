class AssociationsController < ApplicationController

  def index
    @associations = Association.where(user_id: current_user.id)
  end

  def new
    @association = Association.new
  end

  def create
    if current_user.id == params[:associate_id].to_i
        flash[:notice] = "You can't add your own profile."
        redirect_to associations_path
    elsif already_associates?(params[:associate_id])
      flash[:notice] = "You are already associates."
      redirect_to associations_path
    else
      @association = current_user.associations.build(associate_id: params[:associate_id], latitude: params[:lat], longitude: params[:long], event: current_user.event)
      @opp_association = opposite_association(params[:associate_id], params[:lat], params[:long], current_user.id)
      if @association.save
        @opp_association.save
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


  private

  def opposite_association(associate_id, lat, long, current_user_id)
    other_event = User.find(associate_id).event
    User.find(associate_id).associations.build(associate_id: current_user_id, latitude: lat, longitude: long, event: other_event)
  end

  def already_associates?(associates_id)
    current_user.associations.map do |association|
      association.associate_id
    end.include?(associates_id.to_i)
  end

end
