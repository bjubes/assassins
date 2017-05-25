class KillConfirmationsController < ApplicationController
  before_action :set_kill_confirmation, only: [:show, :edit, :update, :destroy]
  before_action authenticate_user!, only: [:show, :edit, :update, :destroy]

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
    @kill_confirmation = KillConfirmation.new(kill_confirmation_params)

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kill_confirmation
      @kill_confirmation = KillConfirmation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kill_confirmation_params
      params.require(:kill_confirmation).permit(:kill_id, :sender_id, :reciever_id, :verdict)
    end
end
