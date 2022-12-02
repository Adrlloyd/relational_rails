require 'rails_helper'

RSpec.describe 'league_clubs index' do 
  # User Story 5, Parent Children Index 

  # As a visitor
  # When I visit '/parents/:parent_id/child_table_name'
  # Then I see each Child that is associated with that Parent with each Child's attributes
  # (data from each column that is on the child table)

  it 'displays the clubs and its attributes linked to the leagues ID' do
    league1 = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    league2 = League.create!(name: 'MLS', level: 1, country: 'USA', relegation: false)
    club1 = league1.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league1.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)
    club3 = league2.clubs.create!(name: 'Colorado Rapids', position: 1, city: 'Denver', previous_winner: true)
    binding.pry
    visit "/leagues/#{league1.id}/clubs"
    
    expect(page).to have_content(club1.name)
    expect(page).to have_content(club1.position)
    expect(page).to have_content(club1.city)
    expect(page).to have_content(club1.previous_winner)
    expect(page).to have_content(club2.name)
    expect(page).to have_content(club2.position)
    expect(page).to have_content(club2.city)
    expect(page).to have_content(club2.previous_winner)
    expect(page).to_not have_content(club3.name)

    visit "/leagues/#{league2.id}/clubs"

    expect(page).to have_content(club3.name)
    expect(page).to have_content(club3.position)
    expect(page).to have_content(club3.city)
    expect(page).to have_content(club3.previous_winner)
    expect(page).to_not have_content(club1.name)
  end
end