require 'rails_helper'

RSpec.describe 'clubs show page' do 
  # User Story 4, Child Show 

  # As a visitor
  # When I visit '/child_table_name/:id'
  # Then I see the child with that id including the child's attributes
  # (data from each column that is on the child table)

  it 'displays the clubs attributes by ID' do
    league = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    club1 = league.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)

    visit "/clubs/#{club1.id}"
    
    expect(page).to have_content(club1.name)
    expect(page).to have_content(club1.position)
    expect(page).to have_content(club1.city)
    expect(page).to have_content(club1.previous_winner)
    expect(page).to_not have_content(club2.name)
    expect(page).to_not have_content(club2.city)
  end
end