class Wallpaper < ApplicationRecord
  belongs_to :category
  has_one_attached :picture
  paginates_per 9
end
