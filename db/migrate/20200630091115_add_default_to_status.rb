class AddDefaultToStatus < ActiveRecord::Migration[6.0]
  def change
    change_column :requests, :status, :string, default: "pending"
  end
end
