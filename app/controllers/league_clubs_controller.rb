class LeagueClubsController < ApplicationController
  def index
    @league = League.find(params[:league_id])
    @clubs = Club.where(league_id: params[:league_id])
  end

  def new
    @league = League.find(params[:id])
  end

  def create 
    league = League.find(params[:id])
    club = league.clubs.create!(name: params[:name], position: params[:position], city: params[:city], previous_winner: params[:previous_winner])
    redirect_to "/leagues/#{league.id}/clubs"
  end
end