require 'elo_ratings'

class MatchesController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    match = {}
    match[:winner] = Player.find_or_create_by_name(params[:winner_name].downcase)
    match[:loser] = Player.find_or_create_by_name(params[:loser_name].downcase)

    params[:winner_score] = nil if params[:winner_score].blank?
    params[:loser_score] = nil if params[:loser_score].blank?
    if params[:winner_score] or params[:loser_score]
      match[:winner_score] = params[:winner_score] || 0
      match[:loser_score]  = params[:loser_score]  || 0
    end
    
    if match[:winner].valid? &&match[:loser].valid?
      match = Match.new(match)
      match.save!
      EloRatings.add_match(match)
      flash.notice = "Successfully added match between #{params[:winner_name]} and #{params[:loser_name]}"
    else
      flash.alert = "Must specify a winner and a loser to post a match."
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
