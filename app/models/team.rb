class Team < ActiveRecord::Base
  has_many :away_games, :class_name => "Game", :foreign_key => "away_team_id"
  has_many :home_games, :class_name => "Game", :foreign_key => "home_team_id"

  # po dodaniu wyników spotkań
  def update_stats # aktualiazcja wszystkich pol w tabeli
    
  end

  def games
    Game.team_games(sbr_name).order(:date)
  end

  def last_game(date = nil)
    date ||= games.last.date
    games.where("date < '#{date}'").where("total > 10").last
  end

  def o_u
    "#{games.where(:over => 1).size} - #{games.where(:over => -1).size}"
  end



  def breaks
    b = 0
    s = 0
    games.each do |g|
      d = g.date
      if lg = last_game(d)
        puts "#{lg.a_team} @ #{lg.h_team}"
        if lg.over == g.over
          s += 1
        else
          b += 1
        end
      end
    end
    puts "B:#{b} S:#{s}"
    {:b => b, :s => s}
  end

  def self.breaks_stats
    b = 0
    s = 0
    Team.all.each do |t|
      st = t.breaks
      s += st[:s]
      b += st[:b]
    end
    puts "B:#{b} S:#{s}"
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