require 'rails_helper'

RSpec.describe 'leagues show page' do 
  # User Story 2, Parent Show 

  # As a visitor
  # When I visit '/parents/:id'
  # Then I see the parent with that id including the parent's attributes
  # (data from each column that is on the parent table)

  it 'displays the league attributes by ID' do
    league1 = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    league2 = League.create!(name: 'MLS', level: 1, country: 'USA', relegation: false)

    visit "/leagues/#{league1.id}"
    
    expect(page).to have_content(league1.name)
    expect(page).to have_content(league1.level)
    expect(page).to have_content(league1.country)
    expect(page).to have_content(league1.relegation)
    expect(page).to_not have_content(league2.name)
    expect(page).to_not have_content(league2.country)
  end

# User Story 7, Parent Child Count

# As a visitor
# When I visit a parent's show page
# I see a count of the number of children associated with this parent
  it ' displays the total number of clubs for each league' do
    league1 = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    league2 = League.create!(name: 'MLS', level: 1, country: 'USA', relegation: false)
    club1 = league1.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league1.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)
    club3 = league2.clubs.create!(name: 'Colorado Rapids', position: 1, city: 'Denver', previous_winner: true)
  
    visit "/leagues/#{league1.id}"

    expect(page).to have_content(2)
  
  end
end