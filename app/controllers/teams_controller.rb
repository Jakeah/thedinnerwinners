class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_filter :authorize_admin

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

end