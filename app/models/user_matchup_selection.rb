class UserMatchupSelection < ApplicationRecord
  # Schema info: Table user_matchup_selections
  # user_id               :integer   null: false
  # nfl_matchup_id        :integer   null: false
  # selected_winner_id    :integer   null: false
  # confidence_points     :integer   null: false
  # week                  :integer   null: false
  # season_year           :integer   null: false

  belongs_to :user
  belongs_to :nfl_matchup
  belongs_to :selected_winner, class_name: 'Team', foreign_key: 'selected_winner_id'

end