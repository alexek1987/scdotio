class AddBackColumnagain < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :end_date, :date
  end
end
