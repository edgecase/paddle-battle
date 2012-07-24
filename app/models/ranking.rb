class Ranking
  attr_reader :player

  def self.all
    ratings = EloRatings.players_by_rating
    players_by_id = Player.all.index_by{|p| p.id}
    ratings.map do |player_id, elo_player|
      Ranking.new(players_by_id[player_id], elo_player)
    end
  end

  def self.recent
    self.all.select(&:recent?)
  end

  def initialize(player, elo_player)
    @player = player
    @elo_player = elo_player
  end

  def recent?
    player.most_recent_match.occured_at >= 30.days.ago
  end

  def winning_games
    @elo_player.games.select do |g|
      (g.one==@elo_player && g.result > 0.5) || (g.two==@elo_player && g.result < 0.5)
    end
  end

  def wins
    winning_games.size
  end

  def games_played
    @elo_player.games_played
  end

  def losses
    games_played - wins
  end

  def rating
    @elo_player.rating
  end

  def as_json(options)
    {
      player_name:  player.display_name,
      wins:         wins,
      losses:       losses,
      games_played: games_played,
      rating:       rating,
      recent:       recent?
    }
  end
end
