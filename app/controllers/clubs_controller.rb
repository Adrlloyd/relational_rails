class ClubsController < ApplicationController
  def index
    @clubs = Club.all.previous_winner
  end

  def show
    @club = Club.find(params[:id])
  end

  def edit
    @club = Club.find(params[:id])
end

def update 
    club = Club.find(params[:id])
    club.update({
        name: params[:name],
        position: params[:position],
        city: params[:city],
        previous_winner: params[:previous_winner]})
    redirect_to "/clubs/#{club.id}"
end
end