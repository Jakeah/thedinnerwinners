class AdminUtilityController < ApplicationController
  before_action :authenticate_user!
  before_filter :authorize_admin

  def index
  end

  def import_schedule
    @nfl_matchups = NflMatchup.where(season_year: Date.today.year)
  end

  def import_schedule_csv
    if params[:csv]
      NflMatchup.import(params[:file])
      flash[:notice] = "Successfully imported"
      redirect_to action: 'import_schedule'
    end
  end


end
