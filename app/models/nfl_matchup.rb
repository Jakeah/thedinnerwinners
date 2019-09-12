class NflMatchup < ApplicationRecord
  require 'csv'
  # Schema info: Table: nfl_matchups
  # season_year        :integer   null: false
  # home_team_id       :integer   null: false
  # away_team_id       :integer   null: false
  # week               :integer   null: false
  # game_start_time    :datetime
  # matchup_winner_id  :datetime

  belongs_to :home_team, class_name: 'Team', foreign_key: 'home_team_id'
  belongs_to :away_team, class_name: 'Team', foreign_key: 'away_team_id'
  has_one :matchup_winner, class_name: 'Team', foreign_key: 'matchup_winner_id'

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      retrieved_home_team = Team.find_by_name(row['Home'])
      retrieved_away_team = Team.find_by_name(row['Visitor'])
      game_time = DateTime.parse("#{row['Date']} #{row['Time']}")
      NflMatchup.create!(
        home_team_id: retrieved_home_team.id,
        away_team_id: retrieved_away_team.id,
        week: row['Week'].to_i,
        game_start_time: game_time,
        season_year: Date.today.year
      )
    end
  end

end