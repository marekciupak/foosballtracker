json.array!(@players) do |player|
  json.extract! player, :id, :firstname, :lastname
  json.url player_url(player, format: :json)
end
