class ApplicationController < ActionController::Base
  before_action :session_expired

  def session_expired
    if session[:expires_at].nil? || session[:expires_at] < Time.now
      reset_session
      redirect_to start_path, error: "Your session expired, start again"
    end
  end

  def current_voter
    Voter.find(session[:current_voter_id])
  end

  def sign_out
    reset_session
    redirect_to results_path
  end

  def reset_session
    session[:current_voter_id] = nil
    session[:expires_at] = nil
  end
end
