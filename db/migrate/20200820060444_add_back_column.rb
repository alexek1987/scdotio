class AddBackColumn < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :start_date, :date
  end
end
