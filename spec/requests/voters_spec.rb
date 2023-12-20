require 'rails_helper'

RSpec.describe "VotersControllers", type: :request do
  describe "POST /voters" do
    it 'will create/find existing voter and redirect to voting page' do
      post "/voters", params: {voter: {email: "bob@gmail.com", zip_code: "83728"}}
      expect(response).to redirect_to("/vote")
    end
  end

  describe "PUT /voters" do
    it 'will update current_user defined by the session' do
      candidate = Candidate.create(name: "Roger Bob")
      voter = Voter.create(email: "bob@gmail.com", zip_code: 73624)
      session = { current_voter_id: voter.id, expires_at: (Time.now+10.hours).to_s }
      allow_any_instance_of(VotersController).to receive(:session).and_return(session)

      put "/voters/#{voter.id}", params: {voter: {candidate_id: candidate.id}}
      expect(response).to redirect_to("/results")
      expect(voter.reload.candidate_id).to eq(candidate.id)
    end

    it 'will fail if there is no user session' do
      candidate = Candidate.create(name: "Roger Bob")
      voter = Voter.create(email: "bob@gmail.com", zip_code: 73624)

      put "/voters/#{voter.id}", params: {voter: {candidate_id: candidate.id}}
      expect(response).to have_http_status(404)
    end
  end
end
