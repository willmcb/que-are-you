class AddEventToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :event, :string
  end
end
