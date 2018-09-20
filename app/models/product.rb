class Product < ApplicationRecord
  has_and_belongs_to_many :orders
  belongs_to :category
  belongs_to :user

  monetize :price_cents
end
