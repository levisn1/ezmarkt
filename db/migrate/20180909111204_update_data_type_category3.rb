class UpdateDataTypeCategory3 < ActiveRecord::Migration[5.2]
  change_table :categories do |t|
    t.remove :category
  end
end
