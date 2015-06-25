p = Array.new

p.push(Player.create(firstname: 'Daenerys', lastname: 'Targaryen', email: 'daenerys.targaryen@example.localhost'))
p.push(Player.create(firstname: 'Jon', lastname: 'Snow', email: 'jon.snow@example.localhost'))
p.push(Player.create(firstname: 'Arya', lastname: 'Stark', email: 'arya.stark@example.localhost'))
p.push(Player.create(firstname: 'Sansa', lastname: 'Stark', email: 'sansa.stark@example.localhost'))
p.push(Player.create(firstname: 'Tyrion', lastname: 'Lannister', email: 'tyrion.lannister@example.localhost'))

100.times {
	Match.create(
		date: rand(2.months).seconds.ago, 
		winner: winner = p.sample, 
		loser: p.reject{|p| p == winner}.sample, 
		loser_score: rand(0..9)
	)
}
