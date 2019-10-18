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
    @user_matchup_selections = UserMatchupSelection.where(user_id: current_user.id, week: @week, season_year: Date.today.year).order(nfl_matchup_id: 'asc')
    @max_confidence_points = @nfl_matchups.count
    points_sum_check = @max_confidence_points*(@max_confidence_points + 1)/2
    points_sum = 0
    params[:matchup_points].each do |id, v|
      points_sum += v.to_i
    end
    if !params[:matchup_winner].blank? && 
        @nfl_matchups.count == params[:matchup_points].count &&
        points_sum_check == points_sum
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
      @user_matchup_selections = UserMatchupSelection.where(user_id: current_user.id, week: @week, season_year: Date.today.year).order(nfl_matchup_id: 'asc')
      flash[:warning] = nil
      flash[:notice] = "Successfully submitted picks for week #{@week}"
      render :show
    else
      flash[:warning] = "MATCHUP WINNER BLANK OR NOT ALL PICKS HAVE POINTS OR POINTS SUM IS OFF"
      render :show
    end

  end

  def update_picks
    @week = params[:id].to_i
    @nfl_matchups = NflMatchup.where(week: @week, season_year: Date.today.year)
    @max_confidence_points = @nfl_matchups.count
    @user_matchup_selections = UserMatchupSelection.where(user_id: current_user.id, week: @week, season_year: Date.today.year).order(nfl_matchup_id: 'asc')
    points_sum_check = @max_confidence_points*(@max_confidence_points + 1)/2
    points_sum = 0
    params[:user_matchup_points].each do |id, v|
      points_sum += v.to_i
    end
    if points_sum == points_sum_check
      params[:user_matchup_winner].each do |selection_id, val|
        user_matchup_selection = UserMatchupSelection.find(selection_id.to_i)
        user_matchup_selection.selected_winner_id = val.to_i
        user_matchup_selection.confidence_points = params[:user_matchup_points][selection_id].to_i
        unless user_matchup_selection.save
          flash[:warning] = 'Error updating picks'
        end
      end
      flash[:warning] = nil
      flash[:notice] = "Successfully updated picks for week #{@week}"
      render :show
    else
      flash[:notice] = nil
      flash[:warning] = "POINTS SUM IS OFF"
      render :show
    end
  end


end
