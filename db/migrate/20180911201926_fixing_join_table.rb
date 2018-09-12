class FixingJoinTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :orders_products
  end
end
