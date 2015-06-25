require 'rails_helper'

RSpec.describe Player, type: :model do
  let(:player1) { create(:player1) }

  it 'has a valid factory' do
    expect(build(:player1)).to be_valid
    expect(build(:player2)).to be_valid
  end

  it 'is invalid without a firstname' do
    expect(build(:player1, firstname: nil)).to_not be_valid
  end

  it 'is invalid without a lastname' do
    expect(build(:player1, lastname: nil)).to_not be_valid
  end

  it 'is invalid without correct email address' do
    expect(build(:player1, email: 'email@pl')).to_not be_valid
  end

  describe '#fullname' do
    it 'returns fullname' do
      expect(player1.fullname).to eq("#{player1.firstname} #{player1.lastname}")
    end
  end
end
