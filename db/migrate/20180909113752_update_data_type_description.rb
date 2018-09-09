class UpdateDataTypeDescription < ActiveRecord::Migration[5.2]
  change_table :products do |t|
    t.remove :description
    t.text :description
  end
end
