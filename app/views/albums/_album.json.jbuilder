json.extract! album, :id, :name, :artist, :store_id, :created_at, :updated_at
json.url album_url(album, format: :json)
