class LeaguesController < ApplicationController
  def index
    @leagues = League.sort_all
  end

  def show
    @league = League.find(params[:id])
  end

  def new
  end
  
  def create 
    league = League.create!({
        name: params[:name],
        level: params[:level],
        country: params[:country],
        relegation: params[:relegation]})
    redirect_to "/leagues"
  end
end