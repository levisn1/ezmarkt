class Addmissingcolumns2 < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :ordinable, :boolean, :default => true
  end
end
