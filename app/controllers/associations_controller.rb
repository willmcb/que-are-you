class AssociationsController < ApplicationController

  # GET /associations
  # GET /associations.json
  def index
    @associations = Association.where(user_id: current_user.id)
  end

  # GET /associations/1
  # GET /associations/1.json
  def show
  end

  # GET /associations/new
  def new
    @association = Association.new
  end

  # GET /associations/1/edit
  def edit
  end

  # POST /associations
  # POST /associations.json
  def create
    @association = current_user.associations.build(associate_id: params['association']['associate_id'])
    @opp_association = opposite_association(params['association']['associate_id'], current_user.id)
    respond_to do |format|
      if @association.save && @opp_association.save
        format.html { redirect_to associations_path, notice: 'Association was successfully created.' }
        format.json { render :show, status: :created, location: @association }
      else
        format.html { render :new }
        format.json { render json: @association.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /associations/1
  # PATCH/PUT /associations/1.json
  def update
  end

  # DELETE /associations/1
  # DELETE /associations/1.json
  def destroy
    @association = current_user.associations.find_by(
      associate_id: params['associate_id']
    )
    @opp_association = User.find(
      params['associate_id']
    ).associations.find_by(associate_id: current_user.id)
    @association.destroy
    @opp_association.destroy
    redirect_to associations_path
  end

  private

  def opposite_association(associate_id, current_user_id)
    User.find(associate_id).associations.build(associate_id: current_user_id)
  end
end
