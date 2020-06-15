json.extract! event, :id, :game, :owner, :title, :text, :date, :latest, :user_id, :created_at, :updated_at
json.url event_url(event, format: :json)
