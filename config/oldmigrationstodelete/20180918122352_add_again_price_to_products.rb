class AddAgainPriceToProducts < ActiveRecord::Migration[5.2]
  change_table :products do |t|
    t.remove :price
  end
end
