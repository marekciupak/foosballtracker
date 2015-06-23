class Player < ActiveRecord::Base
	has_many :victories, :class_name => "Match", :foreign_key => 'winner_id'
	has_many :lost, :class_name => "Match", :foreign_key => 'loser_id'
end
