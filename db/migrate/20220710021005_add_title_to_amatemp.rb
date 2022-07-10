class AddTitleToAmatemp < ActiveRecord::Migration[7.0]
  def change
    add_column :amatemps, :title, :string
  end
end
