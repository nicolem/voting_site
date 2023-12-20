class VotersController < ApplicationController
  before_action :set_voter, only: %i[ update ]
  skip_before_action :session_expired

  # GET /voters/new
  def new
    @voter = Voter.new
  end

  # POST /voters or /voters.json
  def create
    @voter = Voter.find_or_create_by(email: voter_params[:email])
    session[:current_voter_id] = @voter.id
    session[:expires_at] = 5.minutes.from_now

    respond_to do |format|
      if @voter.update(voter_params)
        format.html { redirect_to vote_path}
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /voters/1 or /voters/1.json
  def update
    @voter.update(voter_params)
    sign_out
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_voter
    @voter = Voter.find(session[:current_voter_id])
  end

  # Only allow a list of trusted parameters through.
  def voter_params
    params.require(:voter).permit(:email, :zip_code, :candidate_id)
  end
end