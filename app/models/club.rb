class Club < ApplicationRecord
  belongs_to :league

  def self.previous_winner
    Club.all.where(previous_winner: true)
  end

  def self.sort_alphabetically
    Club.order(:name)
  end

  def self.league_position(pos_in_league)
    pos_in_league = 0 if pos_in_league.empty?
    where("position >= #{pos_in_league}")
  end
end