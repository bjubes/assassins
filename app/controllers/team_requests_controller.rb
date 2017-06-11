class TeamRequestsController < ApplicationController
  before_action :set_team_request, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /team_requests
  # GET /team_requests.json
  def index
    @invites = current_user.recieved_team_requests
    @sent = current_user.sent_team_requests
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
      @team_request = TeamRequest.new(sender: current_user,
                                      reciever_id: team_request_params[:reciever_id],
                                      team: current_user.team)
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
    if @team_request.status != "pending"
      flash[:notice] = "could not delete team request."
      redirect_to action: "index"
    else
      @team_request.destroy
      respond_to do |format|
        format.html { redirect_to team_requests_url, notice: 'Team request was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def accept
    @team_request = TeamRequest.find(params[:request_id])

    if @team_request.accept(current_user)
      #accepted successfully
      flash[:notice] = "successfully joined '#{@team_request.team.name}'"
      redirect_to @team_request.team
    else
      #error accepting request
      flash[:error] = "Could not join '#{@team_request.team.name}'."

    end
  end

  def deny
    @team_request = TeamRequest.find(params[:request_id])
    if @team_request.deny(current_user)
      #accepted successfully
      flash[:notice] = "Team Request Declined"
    else
      #error accepting request
      flash[:error] = "Error."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_request
      @team_request = TeamRequest.find(params[:id])
    end

    # Only allows reciever_id, the sender and team are inferred from current_user
    def team_request_params
      params.require(:team_request).permit(:reciever_id)
    end
end
