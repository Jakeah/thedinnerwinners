class NflMatchup < ApplicationRecord
  # Schema info: Table: nfl_matchups
  # season_year        :integer   null: false
  # home_team_id       :integer   null: false
  # away_team_id       :integer   null: false
  # week               :integer   null: false
  # game_start_time    :datetime
  # matchup_winner_id  :datetime

  belongs_to :home_team, class_name: 'Team', foreign_key: 'home_team_id'
  belongs_to :away_team, class_name: 'Team', foreign_key: 'away_team_id'
  belongs_to :matchup_winner, class_name: 'Team', foreign_key: 'matchup_winner_id'

end