class TeamRequestsController < ApplicationController
  before_action :set_team_request, only: [:show, :edit, :update, :destroy]

  # GET /team_requests
  # GET /team_requests.json
  def index
    @team_requests = TeamRequest.all
  end

  # GET /team_requests/1
  # GET /team_requests/1.json
  def show
  end

  # GET /team_requests/new
  def new
    @team_request = TeamRequest.new
  end

  # GET /team_requests/1/edit
  def edit
  end

  # POST /team_requests
  # POST /team_requests.json
  def create
    @team_request = TeamRequest.new(team_request_params)

    respond_to do |format|
      if @team_request.save
        format.html { redirect_to @team_request, notice: 'Team request was successfully created.' }
        format.json { render :show, status: :created, location: @team_request }
      else
        format.html { render :new }
        format.json { render json: @team_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_requests/1
  # PATCH/PUT /team_requests/1.json
  def update
    respond_to do |format|
      if @team_request.update(team_request_params)
        format.html { redirect_to @team_request, notice: 'Team request was successfully updated.' }
        format.json { render :show, status: :ok, location: @team_request }
      else
        format.html { render :edit }
        format.json { render json: @team_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_requests/1
  # DELETE /team_requests/1.json
  def destroy
    @team_request.destroy
    respond_to do |format|
      format.html { redirect_to team_requests_url, notice: 'Team request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_request
      @team_request = TeamRequest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_request_params
      params.require(:team_request).permit(:sender_id, :reciever_id, :team_id)
    end
end
