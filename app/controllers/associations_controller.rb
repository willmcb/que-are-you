class AssociationsController < ApplicationController

  def index
    @associations = Association.where(user_id: current_user.id)
  end

  def new
    @association = Association.new
  end

  def create
    @association = current_user.associations.build(:associate_id => params[:associate_id])
    @opp_association = opposite_association(params[:associate_id], current_user.id)
    if @association.save && @opp_association.save
      flash[:notice] = "Added associate."
      redirect_to associations_path
    else
      flash[:notice] = "Unable to add associate."
      redirect_to root_url
    end
  end

  private

  def opposite_association(associate_id, current_user_id)
    User.find(associate_id).associations.build(associate_id: current_user_id)
  end

end
