class AddPackageandweightToAlbums < ActiveRecord::Migration[7.0]
  def change
    add_column :albums, :package, :text
    add_column :albums, :weight, :text
  end
end
