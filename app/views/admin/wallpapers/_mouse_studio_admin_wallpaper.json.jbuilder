json.extract! wallpaper, :id, :category, :picture, :created_at, :updated_at
json.url admin_wallpaper_url(wallpaper, format: :json)
json.picture url_for(wallpaper.picture)
