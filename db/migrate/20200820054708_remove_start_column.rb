class RemoveStartColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :start_date
  end
end
