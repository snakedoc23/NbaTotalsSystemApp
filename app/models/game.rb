class Game < ActiveRecord::Base
  belongs_to :away_team, :class_name => "Team"
  belongs_to :home_team, :class_name => "Team"

  after_save :add_totals

  def fetch_games # pobiera mecze na 
    
  end

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
end
