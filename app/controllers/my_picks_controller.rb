class MyPicksController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  # id param is the week #
  def show
    @week = params[:id].to_i
    @user = current_user
    @user_matchup_selections = UserMatchupSelection.where(user_id: current_user.id, week: @week, season_year: Date.today.year).order(nfl_matchup_id: 'asc')
    @nfl_matchups = NflMatchup.where(week: @week, season_year: Date.today.year).order(game_start_time: 'asc')
    @max_confidence_points = @nfl_matchups.count
  end

  def create_new
    @week = params[:id].to_i
    @nfl_matchups = NflMatchup.where(week: @week, season_year: Date.today.year)
    if !params[:matchup_winner].blank? && @nfl_matchups.count == params[:matchup_points].count
      params[:matchup_winner].each do |nfl_matchup_id, val|
        ums = UserMatchupSelection.create(
          user_id: current_user.id,
          nfl_matchup_id: nfl_matchup_id,
          selected_winner_id: val,
          week: @week,
          season_year: Date.today.year,
          confidence_points: params[:matchup_points][nfl_matchup_id]
        )
      end
    else
      flash[:warning] = "MATHCUP WINNER BLANK OR COUNT OFF"
      render :show
    end

    redirect_to action: :show
  end

  def update
    @week = params[:id].to_i
  end


end
