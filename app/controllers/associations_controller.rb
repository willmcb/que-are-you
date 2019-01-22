class AssociationsController < ApplicationController
  before_action :set_association, only: [:show, :edit, :update, :destroy]

  # GET /associations
  # GET /associations.json
  def index
    @associations = Association.all
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
    @association = current_user.associations.build(associate_id: params['associate_id'])
    @opp_association = opposite_association(params['associate_id'], current_user.id)
    respond_to do |format|
      if @association.save
        format.html { redirect_to @association, notice: 'Association was successfully created.' }
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
  end

  private

  def opposite_friendship(associate_id, current_user_id)
    User.find(associate_id).associations.build(associate_id: current_user_id)
  end
end
