json.extract! video, :id, :title, :description, :tags, :created_at, :updated_at
json.url video_url(video, format: :json)
