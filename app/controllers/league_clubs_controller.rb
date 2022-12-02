class LeagueClubsController < ApplicationController
  def index
    @league = League.find(params[:id])
    @clubs = Club.find(id: params[:id])
  end
end