class Costume < ApplicationRecord
  CATEGORIES = ["superhero", "historical", "movie", "tv show", "animal", "other"]
  SIZES = ["S", "M", "L", "XL", "XXL", "other"]

  # validations
  validates :name, :category, :size, :description, :price_per_day, presence: true
  validates :name, :description, uniqueness: true
  validates :name, :description, length: { minimum: 5 }
  validates :price_per_day, numericality: { greater_than: 0 }
  validates :category, inclusion: { in: CATEGORIES }
  validates :size, inclusion: { in: SIZES }

  # associations
  has_one :booking
  belongs_to :user

  # active storage
  has_many_attached :photos
end
