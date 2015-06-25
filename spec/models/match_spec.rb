require 'rails_helper'

RSpec.describe Match, type: :model do
  let(:player1) { create(:player1) }
  let(:player2) { create(:player1) }

  it 'has a valid factory' do
    expect(build(:match)).to be_valid
  end

  it 'is invalid without a winner' do
    expect(build(:match, winner: nil)).to_not be_valid
  end

  it 'is invalid without a loser' do
    expect(build(:match, loser: nil)).to_not be_valid
  end

  it 'is invalid without a loser_score' do
    expect(build(:match, loser_score: nil)).to_not be_valid
  end

  it 'is invalid without a date' do
    expect(build(:match, date: nil)).to_not be_valid
  end

  it 'is invalid with two the same players' do
    expect(build(:match, winner: player1, loser: player1)).to_not be_valid
  end

  it 'has proper ranking points calculator' do
    match = create(:match)
    expect(match.winner.rank).to eq(0.100875E4)
  end
end
