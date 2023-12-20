require 'rails_helper'

RSpec.describe Voter, type: :model do
  describe 'validations' do
    it 'does not allow duplicate email adresses' do
      Voter.create(email: "user@example.com")
      new_voter = Voter.create(email: "user@example.com")
      expect(new_voter).to be_invalid
      expect(new_voter.errors[:email]).to include("has already been taken")
    end

    it 'requires an email address' do
      voter = Voter.create(email: "")
      expect(voter).to be_invalid
      expect(voter.errors[:email]).to include("can't be blank")
    end

    it 'requires a valid email address format' do
      voter = Voter.create(email: "bob")
      expect(voter).to be_invalid
      expect(voter.errors[:email]).to include("is invalid")
    end
  end

end
