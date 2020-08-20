class RemoveEndColumn < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :end_date
  end
end
