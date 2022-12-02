class LeaguesController < ApplicationController
  def index
    @leagues = League.sort_all
  end

  def show
    @league = League.find(params[:id])
  end
end