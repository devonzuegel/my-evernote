json.array!(@notes) do |note|
  json.extract! note, :id, :guid, :title, :content, :en_created_at, :en_updated_at, :active, :notebook_guid, :author, :notebook_id
  json.url note_url(note, format: :json)
end
