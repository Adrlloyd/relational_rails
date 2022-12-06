class Club < ApplicationRecord
  belongs_to :league

  def self.previous_winner
    Club.all.where(previous_winner: true)
  end

  def self.sort_alphabetically
    Club.order('lower(name)')
  end
end