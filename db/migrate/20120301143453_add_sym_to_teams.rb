class AddSymToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :sym, :string

  end
end
