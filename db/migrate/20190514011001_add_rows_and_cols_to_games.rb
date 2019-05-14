class AddRowsAndColsToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :rows, :integer
    add_column :games, :cols, :integer
  end
end
