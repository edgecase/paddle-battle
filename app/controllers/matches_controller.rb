require 'elo_ratings'

class MatchesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    match = Match.new(occured_at: params[:occured_at])
    match.winner_score = 0
    match.loser_score = 0

    player_one = Player.find_or_create_by_name(params[:one_name].downcase)
    player_two = Player.find_or_create_by_name(params[:two_name].downcase)

    Match::MATCH_SIZE.times do |i|
      unless params["game_#{i}_score_one"].to_i == 0 and params["game_#{i}_score_two"].to_i == 0
        if (params["game_#{i}_score_one"].to_i) > (params["game_#{i}_score_two"].to_i)
          match.games.build(winner: player_one, winner_score: params["game_#{i}_score_one"].to_i,
                            loser:  player_two, loser_score:  params["game_#{i}_score_two"].to_i)
        else
          match.games.build(winner: player_two, winner_score: params["game_#{i}_score_two"].to_i,
                            loser:  player_one, loser_score:  params["game_#{i}_score_one"].to_i)
        end
      end
    end
    
    if match.valid? && match.winner.valid? && match.loser.valid?
      match.save!
      EloRatings.add_match(match)
      flash.notice = "Successfully added match between #{params[:one_name]} and #{params[:two_name]}"
    else
      flash.alert = "Must specify a winner and a loser to post a match. #{match.errors.messages.inspect}"
    end
    redirect_to :back
  end

  def destroy
    Match.find(params[:id]).destroy
    EloRatings.recompute
    redirect_to matches_path
  end
  
  def index
    @match = Match.new
    @matches = Match.order("occured_at desc").includes([:winner, :loser])
  end

end
