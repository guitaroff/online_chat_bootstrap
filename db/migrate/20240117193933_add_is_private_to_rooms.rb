class AddIsPrivateToRooms < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :is_private, :boolean, null: false, default: false
  end
end
