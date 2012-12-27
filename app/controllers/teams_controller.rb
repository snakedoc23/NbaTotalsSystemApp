class TeamsController < ApplicationController
  def index
    @teams = Team.order(:sym)
  end
end
