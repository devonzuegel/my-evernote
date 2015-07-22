json.array!(@notebooks) do |notebook|
  json.extract! notebook, :id, :guid, :name, :en_created_at, :en_updated_at, :user_id
  json.url notebook_url(notebook, format: :json)
end
