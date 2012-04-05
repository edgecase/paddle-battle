class Game < ActiveRecord::Base
  validates :match,        presence: true

  validates :winner,       presence: true
  validates :winner_score, presence: true

  validates :loser,        presence: true
  validates :loser_score,  presence: true

  belongs_to :match,       inverse_of: :games
  belongs_to :winner,      class_name: "Player"
  belongs_to :loser,       class_name: "Player"

  def inspect
    if self.valid?
      "Game: #{self.winner.name} defeated #{self.loser.name} #{self.winner_score}-#{self.loser_score}"
    else
      "Game (unfinished): #{self.errors.inspect}"
    end
  end

end
