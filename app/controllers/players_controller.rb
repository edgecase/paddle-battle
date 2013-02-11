require 'elo_ratings'

class PlayersController < ApplicationController
  respond_to :html, :json

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
    load_for_show
  end

  def api_show
    load_for_show
    render json: {
      player: @player.as_json,
      vs: @vs,
      matches: @matches,
      num_wins: @num_wins,
      num_loses: @num_loses,
      elo_player_rating: @elo_player.rating,
      ratings_by_date: @ratings_by_date,
    }
  end

  def rankings
    @match = Match.new
    @rankings = Ranking.all
    respond_with(@rankings)
  end

  def distribution
    @match = Match.new
    @rankings = Ranking.recent
    @top_n = params[:n] ? params[:n].to_i : @rankings.size
  end

  private

  def load_for_show
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


  def format_names(names)
    names.collect(&:downcase).sort.uniq.collect(&:titleize)
  end
end
