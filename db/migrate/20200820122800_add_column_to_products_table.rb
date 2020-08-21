class AddColumnToProductsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :freebie, :string
  end
end
