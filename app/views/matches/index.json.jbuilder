json.array!(@matches) do |match|
  json.extract! match, :id, :winner_id, :loser_id, :date, :loser_score
  json.url match_url(match, format: :json)
end
