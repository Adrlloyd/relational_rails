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

  def edit
    @league = League.find(params[:id])
  end

  def update
    league = League.find(params[:id])
    league.update({
      name: params[:name],
      level: params[:level],
      country: params[:country],
      relegation: params[:relegation]})
      redirect_to "/leagues/#{league.id}"
  end

  def destroy
    League.destroy(params[:id])
    redirect_to "/leagues"
  end
end