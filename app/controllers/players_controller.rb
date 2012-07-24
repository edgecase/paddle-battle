require 'elo_ratings'

class PlayersController < ApplicationController

  def index
    if params[:q]
      query = params[:q].downcase + '%'
      names = Player.where(["LOWER(name) LIKE ?", query]).collect(&:name)
    else
      names = Player.all.collect(&:name)
    end

    render text: format_names(names).join("\n")
  end

  def api_index
    render json: format_names(Player.all.collect(&:name))
  end

  def show
    @match = Match.new
    @player = Player.find(params[:id])
    @matches = @player.matches.order("occured_at desc")
    if params[:vs]
      @vs = Player.find(params[:vs])
      @matches.reject!{|m| ![m.winner_id, m.loser_id].include?(@vs.id)}
      @num_wins = @matches.select{|m| m.winner_id == @player.id}.size
      @num_loses = @matches.select{|m| m.loser_id == @player.id}.size
    else
      @num_wins = @player.winning_matches.size
      @num_loses = @player.losing_matches.size
    end
    @elo_player = EloRatings.get_elo_player(@player.id)

    @ratings_by_date = EloRatings.ratings_by_date(@player.id)
  end

  def rankings
    @match = Match.new
    @ratings = EloRatings.players_by_rating
    @players_by_id = Player.all.index_by{|p| p.id}
  end

  def distribution
    rankings
    @ratings.reject!{|player_id, _| @players_by_id[player_id].most_recent_match.occured_at < 30.days.ago}
    @top_n = params[:n] ? params[:n].to_i : @ratings.size
  end

  private

  def format_names(names)
    names.collect(&:downcase).sort.uniq.collect(&:titleize)
  end
end
