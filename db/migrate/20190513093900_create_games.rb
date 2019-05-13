class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.references :user, foreign_key: true
      t.datetime :started_at
      t.datetime :finished_at

      t.timestamps
    end
  end
end
