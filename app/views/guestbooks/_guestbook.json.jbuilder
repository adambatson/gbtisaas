json.extract! guestbook, :id, :title, :archived, :created_at, :updated_at
json.url guestbook_url(guestbook, format: :json)