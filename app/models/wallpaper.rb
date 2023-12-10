class Wallpaper < ApplicationRecord
  belongs_to :collection
  has_one_attached :picture do |attachable|
    attachable.variant :preview, resize_to_limit: [318, 748], preprocessed: true
  end
  paginates_per 9
end
