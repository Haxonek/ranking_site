json.extract! game, :id, :winner, :loser, :played, :created_at, :updated_at
json.url game_url(game, format: :json)
