json.extract! kill_confirmation, :id, :kill_id, :sender_id, :reciever_id, :verdict, :created_at, :updated_at
json.url kill_confirmation_url(kill_confirmation, format: :json)
