class Category < ApplicationRecord
  has_many :wallpapers

  validates :name, presence: true, uniqueness: true
end
