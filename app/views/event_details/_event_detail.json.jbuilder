json.extract! event_detail, :id, :game_id, :owner, :title, :date, :latest, :boolean, :user_id, :event_id, :created_at, :updated_at
json.url event_detail_url(event_detail, format: :json)
