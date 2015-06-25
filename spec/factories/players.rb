FactoryGirl.define do
  factory :player do |f|
	factory :player1, aliases: [:winner] do |f|
	  f.firstname "John"
	  f.lastname "Doe"
	  f.email "john.doe@example.localhost"
	end

	factory :player2, aliases: [:loser] do |f|
	  f.firstname "Victor"
	  f.lastname "Mills"
	  f.email "victor.mills@example.localhost"
	end
  end
end