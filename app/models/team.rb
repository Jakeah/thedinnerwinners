class Team < ApplicationRecord
  # Schema info: Table teams
  # name      :string
  # shortname :string

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      next if Team.find_by_name(row['Home'])
      game_time = DateTime.parse("#{row['Date']} #{row['Time']}")
      Team.create(
        name: row['Home']
      )
    end
  end
end