class AddScoreToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :winner_score, :int
    add_column :matches, :loser_score, :int
  end
end
