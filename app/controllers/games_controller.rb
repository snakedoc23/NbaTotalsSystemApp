class GamesController < ApplicationController

  def index
    @games = Game.today
  end
end
