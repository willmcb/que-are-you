class CreateAssociations < ActiveRecord::Migration[5.2]
  def change
    create_table :associations do |t|
      t.references :user
      t.references :associate

      t.timestamps
    end
  end
end
