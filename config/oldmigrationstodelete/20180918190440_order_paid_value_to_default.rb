class OrderPaidValueToDefault < ActiveRecord::Migration[5.2]
  change_table :orders do |t|
    t.remove :paid
    t.boolean :paid, default: true
  end
end
