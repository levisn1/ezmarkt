class UpdateDataTypeCategory2 < ActiveRecord::Migration[5.2]
  change_table :categories do |t|
    t.remove :category
    t.string :category
  end
end
