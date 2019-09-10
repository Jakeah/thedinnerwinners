class UserMatchup < ApplicationRecord
  # Schema info: Table user_matchup_selections
  # player_one_id         :integer   null: false
  # player_two_id         :integer   null: false
  # week                  :integer   null: false
  # season_year           :integer   null: false
  # matchup_winner_id     :integer   null: false

  belongs_to :player_one, class_name: 'User', foreign_key: 'player_one_id'
  belongs_to :player_two, class_name: 'User', foreign_key: 'player_two_id'
  belongs_to :matchup_winner, class_name: 'User', foreign_key: 'matchup_winner_id'

end