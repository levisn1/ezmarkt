class Product < ApplicationRecord
  has_and_belongs_to_many :orders
  belongs_to :category
  belongs_to :user

  monetize :price_cents
  mount_uploader :picture, PictureUploader
  validates :name, :description, :category, :price, presence: true
  include PgSearch
  pg_search_scope :search_by_name_and_description,
  against: [ :name, :description ],
  associated_against: {
  category: [ :name ]
  },
  using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
  end
