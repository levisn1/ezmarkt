class FixOrderForStripe < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :state, :string
    add_column :orders, :amount, :monetize
    add_column :orders, :payment, :json
  end
end
