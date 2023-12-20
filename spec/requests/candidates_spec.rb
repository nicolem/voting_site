require 'rails_helper'

RSpec.describe "Candidates", type: :request do
  describe "GET /results" do
    it "returns HTTP Success" do
      get "/results"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /vote" do
    it "redirects to start page if not logged in" do
      get "/vote"
      expect(response).to redirect_to("/start")
    end

    it "returns HTTP Success if user session present" do
      voter = Voter.create(email: "bob@gmail.com", zip_code: 73624)
      session = { current_voter_id: voter.id, expires_at: (Time.now+10.hours).to_s }
      allow_any_instance_of(CandidatesController).to receive(:session).and_return(session)

      get "/vote"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /candidates" do
    it "redirects to results page if user session present" do
      voter = Voter.create(email: "bob@gmail.com", zip_code: 73624)
      session = { current_voter_id: voter.id, expires_at: (Time.now+10.hours).to_s }
      allow_any_instance_of(CandidatesController).to receive(:session).and_return(session)

      post "/candidates", params: {candidate: {name: "bob"}}
      expect(response).to redirect_to("/results")
    end

    it "redirects to start page if user session not present" do
      post "/candidates", params: {candidate: {name: "bob"}}
      expect(response).to redirect_to("/start")
    end
  end
end
