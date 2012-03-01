class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.date :date
      t.integer :month
      t.string :season

      t.string :a_team
      t.string :h_team
      
      t.integer :a_score
      t.integer :h_score

      t.float :line
      t.float :line_open
      t.integer :total
      t.integer :over

      t.timestamps
    end
  end
end
