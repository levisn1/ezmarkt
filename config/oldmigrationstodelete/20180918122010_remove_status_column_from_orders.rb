class RemoveStatusColumnFromOrders < ActiveRecord::Migration[5.2]
  change_table :orders do |t|
    t.remove :state
  end
end
