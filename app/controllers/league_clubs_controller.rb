class LeagueClubsController < ApplicationController
  def index
    @league = League.find(params[:league_id])
    @clubs = Club.where(league_id: params[:league_id])
    if params[:sort]
      @clubs = Club.sort_alphabetically
    end

    if params[:position]
      @clubs = @clubs.league_position(params[:position])
    end
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