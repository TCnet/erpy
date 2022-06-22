class CreateAmatwithas < ActiveRecord::Migration[7.0]
  def change
    create_table :amatwithas do |t|
      t.string :value
      t.references :album, null: false, foreign_key: true
      t.references :amatemp, null: false, foreign_key: true

      t.timestamps
    end
  end
end
