class Game < ActiveRecord::Base
  require 'open-uri'
  belongs_to :away_team, :class_name => "Team"
  belongs_to :home_team, :class_name => "Team"

  after_save :add_totals

  scope :s2013, where("season LIKE '12-13'")
  scope :s2012, where("season LIKE '11-12'")
  scope :s2011, where("season LIKE '10-11'")
  scope :team_games, lambda { |team| s2013.where("a_team LIKE '#{team}' or h_team LIKE '#{team}'") }
  scope :today, where(:date => Date.today)

  def add_totals # dodaje do tabeli sume punktow oraz uzupelnia pole over
    if a_score && h_score && total == nil
      self.total = a_score + h_score
      x = total - line
      if x > 0
        self.over = 1
      elsif x < 0
        self.over = -1
      else
        self.over = 0
      end
      self.save
      self.add_teams
    end
  end

  def add_teams
    if away_team.nil?
      self.away_team = Team.find_by_sbr_name(self.a_team)
      self.home_team = Team.find_by_sbr_name(self.h_team)
      self.save
    end
  end

 

  # ostatnie mecze teamow
  def a_team_last_games(num)
    Game.team_games(a_team).where("date < '#{date}'").order(:date).last(num)
  end

  def h_team_last_games(num)
    Game.team_games(h_team).where("date < '#{date}'").order(:date).last(num)
  end

  def team_stats(num = 82, tm = 'h')
    if tm == 'a'
      team = a_team
    elsif tm == 'h'
      team = h_team
    end

    stats = {}
    total_line = 0.0
    total_total = 0.0
    total_line_over = 0.0
    total_total_over = 0.0
    total_line_under = 0.0
    total_total_under = 0.0
    x = 0
    o = 0
    u = 0

    h_total_line = 0.0
    h_total_total = 0.0
    h_total_line_over = 0.0
    h_total_total_over = 0.0
    h_total_line_under = 0.0
    h_total_total_under = 0.0
    h_x = 0
    h_o = 0
    h_u = 0
    h_total_off = 0.0
    h_total_def = 0.0

    a_total_line = 0.0
    a_total_total = 0.0
    a_total_line_over = 0.0
    a_total_total_over = 0.0
    a_total_line_under = 0.0
    a_total_total_under = 0.0
    a_x = 0
    a_o = 0
    a_u = 0
    a_total_off = 0.0
    a_total_def = 0.0

    Game.team_games(team).where("date < '#{date}'").last(num).each do |g|
      if g.h_team == team
        h_total_line += g.line
        h_total_total += g.total
        h_total_off += g.h_score
        h_total_def += g.a_score
        h_x += 1
        if g.over == 1
          h_o += 1
          h_total_line_over += g.line
          h_total_total_over += g.total
        elsif g.over == -1
          h_u += 1
          h_total_line_under += g.line
          h_total_total_under += g.total
        end
      elsif g.a_team == team
        a_total_line += g.line
        a_total_total += g.total
        a_total_off += g.a_score
        a_total_def += g.h_score
        a_x += 1
        if g.over == 1
          a_o += 1
          a_total_line_over += g.line
          a_total_total_over += g.total
        elsif g.over == -1
          a_u += 1
          a_total_line_under += g.line
          a_total_total_under += g.total
        end
      end
      total_line += g.line
      total_total += g.total
      x += 1
      if g.over == 1
        o += 1
        total_line_over += g.line
        total_total_over += g.total
      elsif g.over == -1
        u += 1
        total_line_under += g.line
        total_total_under += g.total
      end
    end
    
    stats[:o_u] = "#{o}-#{u}" 
    stats[:line] = (total_line / x).round(2)
    stats[:total] = (total_total / x).round(2)
    stats[:line_o] = (total_line_over / o).round(2)
    stats[:total_o] = (total_total_over / o).round(2)
    stats[:line_u] = (total_line_under / u).round(2)
    stats[:total_u] = (total_total_under / u).round(2)
    stats[:total_off] = ((a_total_off + h_total_off) / x).round(2)
    stats[:total_def] = ((a_total_def + h_total_def) / x).round(2)

    stats[:home] = {}
    stats[:home][:o_u] = "#{h_o}-#{h_u}"
    stats[:home][:line] = (h_total_line / h_x).round(2)
    stats[:home][:total] = (h_total_total / h_x).round(2)
    stats[:home][:line_o] = (h_total_line_over / h_o).round(2)
    stats[:home][:total_o] = (h_total_total_over / h_o).round(2)
    stats[:home][:line_u] = (h_total_line_under / h_u).round(2)
    stats[:home][:total_u] = (h_total_total_under / h_u).round(2)
    stats[:home][:total_off] = (h_total_off / h_x).round(2)
    stats[:home][:total_def] = (h_total_def / h_x).round(2)

    stats[:away] = {}
    stats[:away][:o_u] = "#{a_o}-#{a_u}"
    stats[:away][:line] = (a_total_line / a_x).round(2)
    stats[:away][:total] = (a_total_total / a_x).round(2)
    stats[:away][:line_o] = (a_total_line_over / a_o).round(2)
    stats[:away][:total_o] = (a_total_total_over / a_o).round(2)
    stats[:away][:line_u] = (a_total_line_under / a_u).round(2)
    stats[:away][:total_u] = (a_total_total_under / a_u).round(2)
    stats[:away][:total_off] = (a_total_off / a_x).round(2)
    stats[:away][:total_def] = (a_total_def / a_x).round(2)
    stats
  end

  def self.system_stat
    w = 0
    l = 0
    day = Game.order(:date).first.date
    while day <= Date.yesterday
      bets = system_bet(day)
      w += bets[:w]
      l += bets[:l]
      day = day.next_day
    end

    "#{w} - #{l}"
  end

  def self.system_bet(day)
    b_o = 0
    b_u = 0
    w_o = 0
    w_u = 0
    Game.where(:date => day.to_date).each do |game|
      alg = game.a_team_last_games(1).last
      hlg = game.h_team_last_games(1).last
      if alg && hlg
        if alg.over == hlg.over
          if alg.over == 1
            b_o += 1
            if game.over == 1
              w_o += 1
            end
          elsif alg.over == -1
            b_u += 1
            if game.over == -1
              w_u += 1
            end
          end
        end
      end
    end
    p "Overy do grania #{b_o} - W #{w_o}"
    p "Udery do grania #{b_u} - W #{w_u}"
    {:w => w_o + w_u, :l => b_o + b_u -  w_o - w_u}
  end

  def self.day_o_u(day)
    o = 0
    u = 0
    p = 0
    Game.where(:date => day.to_date).each do |game|
      if game.over == 1
        o += 1
      elsif game.over == -1
        u += 1
      else
        p += 1
      end
    end
    {:o => o, :u => u, :p => p} 
  end

  def self.last_o_u(num = nil)
    n = num || 1
    o = 0
    u = 0
    Game.where("total > 10").last(n).each do |g|
      o += 1 if g.over == 1
      u += 1 if g.over == -1
    end
    "#{o} - #{u}"
  end

  def self.days_o_u
    stats = []
    d = Game.order(:date).first.date
    while d < Date.today
      o_u = Game.day_o_u(d)
      d = d.next_day
      x = ""
      if o_u[:o] > o_u[:u]
        x = "OVERS"
      elsif o_u[:o] < o_u[:u]
          x = "U"
      end
      stats.push "#{d} #{o_u[:o]}-#{o_u[:u]} #{x}"
    end
    stats.each do |day|
      puts day
    end
  end


  def self.fetch_next_games(day = nil)
    day = day || Date.today.strftime("%Y%m%d")
    url = "http://www.sbrforum.com/nba-basketball/odds-scores/#{day}/"
    doc = Nokogiri::HTML(open(url))
    doc.css("table.tbl-odds").each do |game|
      g = Game.create!
      g.date = "#{day}".to_date
      g.month = day.to_date.month
      g.season = "12-13"
      g.a_team = game.css(".tbl-odds-c2").first.text
      g.h_team = game.css(".tbl-odds-c2").last.text
      g.line_open = game.at_css(".tbl-odds-c6").text.gsub("\u00BD", ".5")[0,5].to_f
      g.line = game.at_css(".tbl-odds-c7").text.gsub("\u00BD", ".5")[0,5].to_f
      g.save
    end
  end

  def self.update_scores(day = nil)
    day = day || Date.yesterday.strftime("%Y%m%d")
    url = "http://www.sbrforum.com/nba-basketball/odds-scores/#{day}/"
    doc = Nokogiri::HTML(open(url))
    doc.css("table.tbl-odds").each do |game|
      g = Game.where(:date => "#{day}".to_date).where(:h_team => game.css(".tbl-odds-c2").last.text).first
      if g
        g.a_score = game.css(".tbl-odds-c3").first.text.to_i
        g.h_score = game.css(".tbl-odds-c3").last.text.to_i
        g.line_open = game.at_css(".tbl-odds-c6").text.gsub("\u00BD", ".5")[0,5].to_f
        g.line = game.at_css(".tbl-odds-c7").text.gsub("\u00BD", ".5")[0,5].to_f
        g.save
      else
        p "No games to update in db"
      end
    end
  end

  def self.update_lines(day = nil)
    day = day || Date.today.strftime("%Y%m%d")
    url = "http://www.sbrforum.com/nba-basketball/odds-scores/#{day}/"
    doc = Nokogiri::HTML(open(url))
    doc.css("table.tbl-odds").each do |game|
      g = Game.where(:date => "#{day}".to_date).where(:h_team => game.css(".tbl-odds-c2").last.text).first
      g.line = game.at_css(".tbl-odds-c7").text.gsub("\u00BD", ".5")[0,5].to_f
      g.save
    end
  end

end
