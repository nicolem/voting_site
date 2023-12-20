class CandidatesController < ApplicationController
  skip_before_action :session_expired, only: :results

  # GET /candidates/new
  def new
    @candidate = Candidate.new
  end

  def vote
    @candidates = Candidate.all
    @candidate = Candidate.new
    @voter = current_voter
    if @voter.nil?
      redirect_to start
    end
  end

  def results
    @candidates = Candidate.order(:name)
  end

  # POST /candidates or /candidates.json
  def create
    @candidate = Candidate.create(candidate_params)

    current_voter.update(candidate_id: @candidate.id)
    sign_out
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def candidate_params
      params.require(:candidate).permit(:name)
    end
end
