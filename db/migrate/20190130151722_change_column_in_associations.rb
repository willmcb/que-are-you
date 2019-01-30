class ChangeColumnInAssociations < ActiveRecord::Migration[5.2]
  def change
    rename_column :associations, :events, :event
  end
end
