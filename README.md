# foosballtracker
Online Foosball (Table football) Tracker

Additional gems:
* bootstrap-sass
* devise
* will_paginate
* rspec-rails
* factory_girl_rails

## Description:
User should be able to:
* Add Players. Each player should have a first name, a last name and an avatar.
* Add Match between any 2 previously added players. Each match should have a date and a result. Foosball match ends when either party scores the 10th goal, so it’s sound to assume the winner always has 10 points. 
* Visit each Player’s dedicated page and see basic information (name, avatar), list of the player’s matches and some statistics (average number of points per game, number of matches won and lost etc.)
* Visit Ranking page and see all players classification. The Ranking algorithm is completely up to you. You can go with something really simple or expand on that to make sure it makes sense most of the time. We would love to see your process of tackling this problem, so if you have some additional thoughts about your solution or see room for possible improvements (without necessarily coding them) - please share.

* In addition, there were added pagination and login and authentication for some actions.

## Ranking system
Every new player starts with 1000 points in the ranking. Player's number of points increases or decreases (depending on whether he won or lost) when his new match comes to database.

Increase/decrease the number of points for each player is calculated based on:
* score of the match,
* the probability of winning the game for player (you win with master - you have more points!). I use the normal distribution to calculate the chances of winning for player,
* the number of finished games by player (the match has bigger impact for new players, because system is not so sure about their skills).