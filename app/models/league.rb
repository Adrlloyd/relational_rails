class League < ApplicationRecord
  has_many :clubs, :dependent => :destroy

  def self.sort_all
    self.order(created_at: :desc)
  end

  def clubs_count
    self.clubs.count
  end
end