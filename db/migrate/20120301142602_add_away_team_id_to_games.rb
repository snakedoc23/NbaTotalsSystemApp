class AddAwayTeamIdToGames < ActiveRecord::Migration
  def change
    add_column :games, :away_team_id, :integer

    add_column :games, :home_team_id, :integer

    add_index :games, :home_team_id
    add_index :games, :away_team_id

  end
end
