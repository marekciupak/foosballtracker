class Match < ActiveRecord::Base
 	belongs_to :winner, :class_name => "Player"
 	belongs_to :loser, :class_name => "Player"

	validates :winner, :loser, :date, presence: true
	validates :loser_score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 10 }

	validate :in_a_single_match_can_not_be_the_same_two_players

	def in_a_single_match_can_not_be_the_same_two_players
	    if winner && winner == loser
	      errors.add(:loser, "In a single match can't be the same two players")
    	end
	end

	scope :played_by, ->(player_id) { where("winner_id == :player OR loser_id == :player", {player: player_id}) }
end
