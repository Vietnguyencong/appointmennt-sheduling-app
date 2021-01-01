json.extract! appointment, :id, :user_id, :time, :questions, :created_at, :updated_at
json.url appointment_url(appointment, format: :json)
