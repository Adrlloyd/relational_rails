class Club < ApplicationRecord
  belongs_to :league

  def self.previous_winner
    Club.all.where(previous_winner: true)
  end
end