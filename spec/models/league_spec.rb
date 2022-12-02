require 'rails_helper'

RSpec.describe League do
  it {should have_many :clubs}

  describe '#sort_all' do
    it 'returns the leagues by the most recently created' do
      league1 = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true, created_at: Time.now - 2.days)
      league2 = League.create!(name: 'MLS', level: 1, country: 'USA', relegation: false)

      expect(League.sort_all). to eq([league2, league1])
    end
  end

  describe '#clubs_count' do
    it 'returns the count of the clubs in each league' do
      league1 = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
      league2 = League.create!(name: 'MLS', level: 1, country: 'USA', relegation: false)
      club1 = league1.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
      club2 = league1.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)
      club3 = league2.clubs.create!(name: 'Colorado Rapids', position: 1, city: 'Denver', previous_winner: true)
  
      expect(league1.clubs_count).to eq 2
      expect(league2.clubs_count).to eq 1
    end
  end
end