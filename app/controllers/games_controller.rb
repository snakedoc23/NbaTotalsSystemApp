class GamesController < ApplicationController

  def index
    @games = Game.today
    if @games.empty?
      Game.update_scores
      Game.fetch_next_games
    end
  end
  def day
    @date = params[:date].to_date
    if @date  == Date.today.to_date
      redirect_to :action => index
    end
    @games = Game.where(:date => @date)
    @prev_day = @date.yesterday.strftime("%Y%m%d")
    @next_day = @date.next_day.strftime("%Y%m%d")

    @overs = Game.day_o_u(params[:date])[:o]
    @unders = Game.day_o_u(params[:date])[:u]
    @bets = Game.system_bet(params[:date])
  end

  def update_lines
    Game.update_lines
    redirect_to :action => index
  end
end
