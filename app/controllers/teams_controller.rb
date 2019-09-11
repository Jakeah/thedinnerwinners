class TeamsController < ApplicationController
  before_action :authenticate_user!
  before_filter :authorize_admin

  def index
    @teams = Team.all
  end

  def show
    @team = Team.find(params[:id])
  end

  def create
    params.require(:team).permit!
    @team = Team.new(params[:team])
    if @team.save
      redirect_to @team, notice: "Successfully created team"
    else
      render :new
    end
  end

  def edit
    @team = Team.find(params[:id])
  end

  def update
    params.require(:team).permit!
    @team = Team.find(params[:id])
    if @team.update_attributes(params[:team])
      redirect_to @team, notice: "Successfully created team"
    else
      render :edit
    end
  end

  def new
    @team = Team.new
  end

end
