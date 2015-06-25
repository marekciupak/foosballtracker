FactoryGirl.define do
  factory :match do |f|
	f.date Time.now
    winner
    loser
	f.loser_score 5
  end
end