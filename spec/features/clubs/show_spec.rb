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

# User Story 14, Child Update 

# As a visitor
# When I visit a Child Show page
# Then I see a link to update that Child "Update Child"
# When I click the link
# I am taken to '/child_table_name/:id/edit' where I see a form to edit the child's attributes:
# When I click the button to submit the form "Update Child"
# Then a `PATCH` request is sent to '/child_table_name/:id',
# the child's data is updated,
# and I am redirected to the Child Show page where I see the Child's updated information
  it 'can update clubs with new attribute details' do
    league = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    club1 = league.clubs.create!(name: 'ASRome', position: 1, city: 'rom', previous_winner: true)
    club2 = league.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)

    visit "/clubs/#{club1.id}"

    expect(page).to have_link('Update club')
    click_link('Update club')
    expect(current_path).to eq("/clubs/#{club1.id}/edit")

    fill_in :name, with: "AS Roma"
    fill_in :city, with: "Rome"

    click_button("Submit")
    expect(current_path).to eq("/clubs/#{club1.id}")
    expect(page).to have_content("AS Roma")
    expect(page).to have_content("Rome")
  end
end