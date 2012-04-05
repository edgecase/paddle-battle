class AddScoreToMatches < ActiveRecord::Migration
  def change
    add_column :matches, :winner_score, :int, default: 0
    add_column :matches, :loser_score, :int, default: 0
  end
end
