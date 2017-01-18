json.extract! message, :id, :content, :approved, :created_at, :updated_at
json.url message_url(message, format: :json)