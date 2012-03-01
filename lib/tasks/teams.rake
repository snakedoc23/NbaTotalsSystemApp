desc "Create teams"
task :create_teams => :environment do

  teams = [
    ["Atlanta", "Atlanta", "Hawks", "ATL"],
    ["Boston", "Boston", "Celtics", "BOS"],
    ["Charlotte", "Charlotte", "Bobcats", "CHA"],
    ["Chicago", "Chicago", "Bulls", "CHI"],
    ["Cleveland", "Cleveland", "Cavaliers", "CLE"],
    ["Dallas", "Dallas", "Mavericks", "DAL"],
    ["Denver", "Denver", "Nuggets", "DEN"],
    ["Detroit", "Detroit", "Pistons", "DET"],
    ["Golden State", "Golden State", "Warriors", "GS"],
    ["Houston", "Houston", "Rockets", "HOU"],
    ["Indiana", "Indiana", "Pacers", "IND"],
    ["L.A. Clippers", "Los Angeles", "Clippers", "LAC"],
    ["L.A. Lakers", "Los Angeles", "Lakers", "LAL"],
    ["Memphis", "Memphis", "Grizzlies", "MEM"],
    ["Miami", "Miami", "Heat", "MIA"],
    ["Milwaukee", "Milwaukee", "Bucks", "MIL"],
    ["Minnesota", "Minnesota", "Timberwolves", "MIN"],
    ["New Jersey", "New Jersey", "Nets", "NJ"],
    ["New Orleans", "New Orleans", "Hornets", "NO"],
    ["New York", "New York", "Knicks", "NY"],
    ["Oklahoma City", "Oklahoma City", "Thunder", "OKC"],
    ["Orlando", "Orlando", "Magic", "ORL"],
    ["Philadelphia", "Philadelphia", "76ers", "PHI"],
    ["Phoenix", "Phoenix", "Suns", "PHO"],
    ["Portland", "Portland", "Trail Blazers", "POR"],
    ["Sacramento", "Sacramento", "Kings", "SAC"],
    ["San Antonio", "San Antonio", "Spurs", "SA"],
    ["Toronto", "Toronto", "Raptors", "TOR"],
    ["Utah", "Utah", "Jazz", "UTA"],
    ["Washington", "Washington", "Wizards", "WAS"]
  ]
  teams.each do |team|
    t = Team.create!
    t.name = team[2]
    t.city = team[1]
    t.sbr_name = team[0]
    t.sym = team[3]
    t.save
  end
end