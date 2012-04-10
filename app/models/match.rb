class Match < ActiveRecord::Base
  validates :winner,      presence: true
  validates :loser,       presence: true
  validates :occured_at,  presence: true

  belongs_to :winner, :class_name => 'Player'
  belongs_to :loser, :class_name => 'Player'
  has_many   :games, inverse_of: :match

  before_validation :set_default_occured_at_date, on: :create
  before_validation :determine_winner

  MATCH_SIZE = 5

  def game_scores
    self.games.map do |game|
      if game.winner == self.winner
        [game.winner_score, game.loser_score, :win]
      elsif game.winner == self.loser
        [game.loser_score, game.winner_score, :loss]
      else
        raise "Game winner did not play in this match. Data corruption likely."
      end
    end
  end

  private

  def set_default_occured_at_date
    self.occured_at ||= Time.now
  end

  def determine_winner
    if self.winner.blank? or self.loser.blank?
      one = self.games.first.winner
      two  = self.games.first.loser
      match_score  = {one: 0, two: 0}
      
      self.games.each do |g|
        if g.winner == one
          match_score[:one] += 1
        else # if g.winner == two
          match_score[:two] += 1
        end
      end

      if match_score[:one] > match_score[:two]
        self.winner = one
        self.loser  = two
        self.winner_score = match_score[:one]
        self.loser_score  = match_score[:two]
      else
        self.winner = two
        self.loser  = one
        self.winner_score = match_score[:two]
        self.loser_score  = match_score[:one]
      end

    end
    
  end


  
end
