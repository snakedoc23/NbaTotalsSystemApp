class Team < ActiveRecord::Base
  has_many :away_games, :class_name => "Game", :foreign_key => "away_team_id"
  has_many :home_games, :class_name => "Game", :foreign_key => "home_team_id"

  # po dodaniu wyników spotkań
  def update_stats # aktualiazcja wszystkich pol w tabeli
    
  end


  def games
    # wszystkie mecze 
  end

end


    # t.integer  "overs"
    # t.integer  "unders"
    # t.float    "line"
    # t.float    "total"
    # t.float    "def"
    # t.float    "off"

    # t.integer  "a_overs"
    # t.integer  "a_unders"
    # t.float    "a_line"
    # t.float    "a_total"
    # t.float    "a_def"
    # t.float    "a_off"

    # t.integer  "h_overs"
    # t.integer  "h_unders"
    # t.float    "h_line"
    # t.float    "h_total"
    # t.float    "h_def"
    # t.float    "h_off"