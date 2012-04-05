class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.references :match
      t.references :winner
      t.integer :winner_score
      t.references :loser
      t.integer :loser_score

      t.timestamps
    end
    add_index :games, :winner_id
    add_index :games, :loser_id
  end
end
