class ChangeDataType < ActiveRecord::Migration[5.2]
  change_table :products do |t|
    t.remove :price
    t.integer :price
  end
end
