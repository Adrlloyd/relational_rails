class League < ApplicationRecord
  has_many :clubs

  def self.sort_all
    self.order(created_at: :desc)
  end
end