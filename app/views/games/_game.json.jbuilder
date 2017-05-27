json.extract! game, :id, :name, :code, :owner, :created_at, :updated_at
json.url game_url(game, format: :json)
