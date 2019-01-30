class AddEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :associations, :event, :string
  end
end
