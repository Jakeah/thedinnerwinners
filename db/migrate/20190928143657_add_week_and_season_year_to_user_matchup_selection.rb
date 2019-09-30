class AddWeekAndSeasonYearToUserMatchupSelection < ActiveRecord::Migration[5.0]
  def change
    add_column :user_matchup_selections, :week, :integer
    add_column :user_matchup_selections, :season_year, :integer
  end
end
