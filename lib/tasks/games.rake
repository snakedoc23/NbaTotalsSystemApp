desc "Fetch games"
task :fetch_games => :environment do
  require 'nokogiri'
  require 'open-uri'

  (28..29).each do |x|
    # x = 2
    month = "201202"
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
      g.month = 2
      g.season = "11-12"
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