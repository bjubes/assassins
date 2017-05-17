json.extract! team_request, :id, :sender_id, :reciever_id, :team_id, :created_at, :updated_at
json.url team_request_url(team_request, format: :json)
