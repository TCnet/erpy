class CreateAmatemps < ActiveRecord::Migration[7.0]
  def change
    create_table :amatemps do |t|
      t.string :name
      t.text :value
      t.boolean :isused
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
