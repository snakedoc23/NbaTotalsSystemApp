class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :city
      t.string :sbr_name

      t.integer :overs
      t.integer :unders
      t.float :line
      t.float :total
      t.float :def
      t.float :off

      t.integer :a_overs
      t.integer :a_unders
      t.float :a_line
      t.float :a_total
      t.float :a_def
      t.float :a_off

      t.integer :h_overs
      t.integer :h_unders
      t.float :h_line
      t.float :h_total
      t.float :h_def
      t.float :h_off

      t.timestamps
    end
  end
end
