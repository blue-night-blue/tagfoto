json.extract! secret_phrase, :id, :user_id, :password_digest, :created_at, :updated_at
json.url secret_phrase_url(secret_phrase, format: :json)
