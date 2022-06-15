class AddFabricTypeToAlbum < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :fabric_type, :string
  end
end
