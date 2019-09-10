class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, null: false, default: ""
      t.string :shortname, null:false, default: ""

      t.timestamps
    end

    create_table :nfl_matchups do |t|
      t.integer :season_year, null: false
      t.integer :home_team_id, null: false
      t.integer :away_team_id, null: false
      t.integer :week, null: false
      t.datetime :game_start_time
      t.integer :matchup_winner_id

      t.timestamps
    end

    create_table :user_matchup_selections do |t|
      t.integer :user_id, null: false
      t.integer :nfl_matchup_id, null: false
      t.integer :selected_winner_id
      t.integer :confidence_points

      t.timestamps
    end

    create_table :user_matchups do |t|
      t.integer :player_one_id, null: false
      t.integer :player_two_id, null: false
      t.integer :week, null: false
      t.integer :season_year, null: false
      t.integer :matchup_winner_id
    end


  end
end
