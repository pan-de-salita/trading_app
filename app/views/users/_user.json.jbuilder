json.extract! user, :id, :email, :password, :status, :role, :confirmed_email, :created_at, :updated_at
json.url user_url(user, format: :json)
