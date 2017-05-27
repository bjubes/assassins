class KillConfirmationsController < ApplicationController
  before_action :set_kill_confirmation, only: [:show, :edit, :update, :destroy, :accept, :deny, :veto, :approve]
  before_action :authenticate_user!, only: [:new, :show, :edit, :update, :destroy]
  before_action :deny_unless_receiver, only: [:accept, :deny]

  def index
    @kill_confirmations = KillConfirmation.all
  end
  # GET /kill_confirmations/1
  # GET /kill_confirmations/1.json
  def show
  end

  # GET /kill_confirmations/new
  def new
    @kill_confirmation = KillConfirmation.new
  end

  # GET /kill_confirmations/1/edit
  def edit
  end

  # POST /kill_confirmations
  # POST /kill_confirmations.json
  def create
    @kill_confirmation = KillConfirmation.new_without_kill(kill_confirmation_nokill_params)
    respond_to do |format|
      if @kill_confirmation.save
        format.html { redirect_to @kill_confirmation, notice: 'The Kill was reported.' }
        format.json { render :show, status: :created, location: @kill_confirmation }
      else
        format.html { render :new }
        format.json { render json: @kill_confirmation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kill_confirmations/1
  # PATCH/PUT /kill_confirmations/1.json
  def update
    respond_to do |format|
      if @kill_confirmation.update(kill_confirmation_params)
        format.html { redirect_to @kill_confirmation, notice: 'Kill confirmation was successfully updated.' }
        format.json { render :show, status: :ok, location: @kill_confirmation }
      else
        format.html { render :edit }
        format.json { render json: @kill_confirmation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kill_confirmations/1
  # DELETE /kill_confirmations/1.json
  def destroy
    @kill_confirmation.destroy
    respond_to do |format|
      format.html { redirect_to kill_confirmations_url, notice: 'Kill confirmation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def accept
    begin
      @kill_confirmation.accept!
        flash[:notice] = "You accepted the kill"
    rescue
      flash[:error] = "Could not accept the kill"
    end
    redirect_to @kill_confirmation
  end

  def deny
    begin
      @kill_confirmation.deny!
        flash[:notice] = "You denied the kill"
    rescue
      flash[:error] = "Could not deny the kill"
    end
    redirect_to @kill_confirmation
  end

  def veto
  end

  def approve
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kill_confirmation
      @kill_confirmation = KillConfirmation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kill_confirmation_params
      params.require(:kill_confirmation).permit(:kill_id, :sender_id, :reciever_id, :verdict)
    end

    def kill_confirmation_nokill_params
      params.require(:kill_confirmation).permit(:killer_id, :victim_id, :creator_is_killer)
    end

    def deny_unless_receiver
      if current_user != @kill_confirmation.receiver
        flash[:error] = "You are not the receiver of this confirmation"
        redirect_to @kill_confirmation
      end
    end
end
