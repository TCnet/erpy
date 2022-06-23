class CreateAmagroups < ActiveRecord::Migration[7.0]
  def change
    create_table :amagroups do |t|
      t.string :name
      t.text :remark
      t.boolean :isused
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
