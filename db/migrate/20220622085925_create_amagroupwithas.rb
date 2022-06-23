class CreateAmagroupwithas < ActiveRecord::Migration[7.0]
  def change
    create_table :amagroupwithas do |t|
      t.references :amagroup, null: false, foreign_key: true
      t.references :amatemp, null: false, foreign_key: true

      t.timestamps
    end
  end
end
