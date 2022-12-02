class LeagueClubsController < ApplicationController
  def index
    @league = League.find(params[:league_id])
    @clubs = Club.where(league_id: params[:league_id])
  end
end