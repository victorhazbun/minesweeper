class CreateCells < ActiveRecord::Migration[5.2]
  def change
    create_table :cells do |t|
      t.references :game, foreign_key: true
      t.integer :x_axis
      t.integer :y_axis
      t.boolean :flagged, default: false
      t.boolean :mined, default: false
      t.boolean :revealed, default: false

      t.timestamps
    end
  end
end
