class NewOrderTableForStripe < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :state
      t.boolean :paid
      t.monetize :amount, currency: { present: false }
      t.json :payment
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
