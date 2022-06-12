class AddWarehourseidToInoutplan < ActiveRecord::Migration[5.0]
  def change
    add_reference :inoutplans, :warehouse, foreign_key: true
  end
end
