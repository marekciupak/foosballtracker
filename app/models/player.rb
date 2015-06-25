class Player < ActiveRecord::Base
	has_many :victories, :class_name => "Match", :foreign_key => 'winner_id'
	has_many :lost, :class_name => "Match", :foreign_key => 'loser_id'

	validates :firstname, :lastname, presence: true
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

	def fullname; "#{firstname} #{lastname}" end
	
	def the_numer_of_won_matches; self.victories.count end
	def the_numer_of_lost_matches; self.lost.count end
	def the_number_of_points_in_lost_matches; self.lost.sum("loser_score") end

	def the_total_numer_of_matches
		the_numer_of_won_matches + the_numer_of_lost_matches 
	end

	def the_total_number_of_points
		10 * the_numer_of_won_matches + the_number_of_points_in_lost_matches
	end

	def the_average_number_of_points_per_match
		the_total_number_of_points / (the_total_numer_of_matches.nonzero? || 1)
	end
end
