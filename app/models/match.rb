class Match < ActiveRecord::Base
 	belongs_to :winner, :class_name => "Player"
 	belongs_to :loser, :class_name => "Player"

	validates :winner, :loser, :date, presence: true
	validates :loser_score, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than: 10 }

	validate :in_a_single_match_can_not_be_the_same_two_players

	def in_a_single_match_can_not_be_the_same_two_players
	    if winner && winner == loser
	      errors.add(:loser, "In a single match can't be the same two players")
    	end
	end

	after_create :update_ranks

	scope :played_by, ->(player_id) { where("winner_id = :player OR loser_id = :player", {player: player_id}) }

	def update_ranks
      # how much different were the players skills?
      # or, better:
      # what was the probability that loser will lose the match with winner
      loser_chances = cdf(self.loser.rank - self.winner.rank)

      # the most recent game should have more impact on new players
      # they tend to have more fluctuations than well-established players
      winner_kfactor = loser_kfactor = 2.7
      winner_kfactor += 0.8 if self.winner.the_total_numer_of_matches <= 5
      loser_kfactor += 0.8 if self.loser.the_total_numer_of_matches <= 5

      # how strong/crushing was the victory
      points_advantage = 10 - self.loser_score

      winner_new_rank = self.winner.rank + loser_chances * points_advantage * winner_kfactor
      loser_new_rank = self.loser.rank - loser_chances * points_advantage * loser_kfactor

      self.winner.update(rank: winner_new_rank)
      self.loser.update(rank: loser_new_rank)
    end

    # normal cumulative distribution function (mean = 0, standard deviation = 200*sqrt(2))
    def cdf(x)
      (0.5 * (1.0 + Math.erf((x*1.0)/(282.842712474619*Math.sqrt(2)))))
    end
end
