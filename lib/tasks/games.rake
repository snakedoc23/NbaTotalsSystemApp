desc "Fetch games"
task :fetch_games => :environment do
  require 'nokogiri'
  require 'open-uri'

  # 30, 31 10
  # 1..21, 23-30 11
  # 1..23, 25-26 12
  days = [
    { :d => [30, 31], :m => 10 },
    { :d => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,23,24,25,26,27,28,29,30], :m => 11 },
    { :d => [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,25,26,27,28,29,30,31], :m => 12 }
  ]

  days.each do |mm|
    mm[:d].each do |x|
      # x = 2
      month = "2012#{mm[:m].to_s}"
      day = x.to_s
      day = "0#{x.to_s}" if x < 10
      day = "#{month}#{day}"
      url = "http://www.sbrforum.com/nba-basketball/odds-scores/#{day}/"
      doc = Nokogiri::HTML(open(url))
      puts doc.at_css("title").text.split.last
      x = 0;
      doc.css("table.tbl-odds").each do |game|
        g = Game.create!
        g.date = "#{day}".to_date
        g.month = mm[:m]
        g.season = "12-13"
        g.a_team = game.css(".tbl-odds-c2").first.text
        g.h_team = game.css(".tbl-odds-c2").last.text
        g.a_score = game.css(".tbl-odds-c3").first.text.to_i
        g.h_score = game.css(".tbl-odds-c3").last.text.to_i
        g.line_open = game.at_css(".tbl-odds-c6").text.gsub("\u00BD", ".5")[0,5].to_f
        g.line = game.at_css(".tbl-odds-c7").text.gsub("\u00BD", ".5")[0,5].to_f
        g.save
      end
    end
  end
end