# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

100.times do
  product = Product.new(
    name: Faker::Commerce.product_name,
    description: Faker::Commerce.material,
    category_id: rand(1..5),
    ordinable: true,
    picture: "https://picsum.photos/216/?random",
    user_id: 1,
    price_cents: rand(0..2000)
  )
  product.save!
end
