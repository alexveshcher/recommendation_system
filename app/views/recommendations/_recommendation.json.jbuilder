json.extract! recommendation, :id, :user_id, :video_id, :importance, :created_at, :updated_at
json.url recommendation_url(recommendation, format: :json)
