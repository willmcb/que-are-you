class AddLocationToAssociation < ActiveRecord::Migration[5.2]
  def change
    add_column :associations, :longitude, :string
    add_column :associations, :latitude, :string
  end
end
