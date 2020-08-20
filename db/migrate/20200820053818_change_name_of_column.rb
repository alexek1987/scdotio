class ChangeNameOfColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :products, :breed, :brand
  end
end
