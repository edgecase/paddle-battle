class Game < ActiveRecord::Base
  validates :match,        presence: true

  validates :winner,       presence: true
  validates :winner_score, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate  :validate_win
  
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

  private

  def validate_win
    unless self.winner_score > self.loser_score
      self.errors.add(:score, "there's no tying in Ping Pong!")
    end
  end

end
