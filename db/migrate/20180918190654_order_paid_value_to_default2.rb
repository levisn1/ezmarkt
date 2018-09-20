class OrderPaidValueToDefault2 < ActiveRecord::Migration[5.2]
  change_table :orders do |t|
    t.remove :paid
    t.boolean :paid, default: false
  end
end
