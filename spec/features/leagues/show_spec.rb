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

  # User Story 10, Parent Child Index Link

  # As a visitor
  # When I visit a parent show page ('/parents/:id')
  # Then I see a link to take me to that parent's `child_table_name` page ('/parents/:id/child_table_name')
  it 'has a link to the clubs in the league' do
    league1 = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    league2 = League.create!(name: 'MLS', level: 1, country: 'USA', relegation: false)
    club1 = league1.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league1.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)
    club3 = league2.clubs.create!(name: 'Colorado Rapids', position: 1, city: 'Denver', previous_winner: true)
  
    visit "/leagues/#{league1.id}"

    expect(page).to have_link("Clubs")
    click_link("Clubs")
    expect(current_path).to eq("/leagues/#{league1.id}/clubs")
  end

# User Story 12, Parent Update 

# As a visitor
# When I visit a parent show page
# Then I see a link to update the parent "Update Parent"
# When I click the link "Update Parent"
# Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's attributes:
# When I fill out the form with updated information
# And I click the button to submit the form
# Then a `PATCH` request is sent to '/parents/:id',
# the parent's info is updated,
# and I am redirected to the Parent's Show page where I see the parent's updated info
  it 'leagues can be updated with new attribute information' do
    league1 = League.create!(name: 'Serie', level: 1, country: 'Ital', relegation: true)
    club1 = league1.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league1.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)

    visit "/leagues/#{league1.id}"

    expect(page).to have_link('Update League')
    click_link('Update League')
    expect(current_path).to eq("/leagues/#{league1.id}/edit")
    
    fill_in :name, with: "Serie A"
    fill_in :country, with: "Italy"

    click_button("Submit")
    expect(current_path).to eq("/leagues/#{league1.id}")
    expect(page).to have_content("Serie A")
    expect(page).to have_content("Italy")
  end

# User Story 19, Parent Delete 

# As a visitor
# When I visit a parent show page
# Then I see a link to delete the parent
# When I click the link "Delete Parent"
# Then a 'DELETE' request is sent to '/parents/:id',
# the parent is deleted, and all child records are deleted
# and I am redirected to the parent index page where I no longer see this parent
  it 'has a link to delete a league and all its clubs data' do
    league1 = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    league2 = League.create!(name: 'MLS', level: 1, country: 'USA', relegation: false)
    club1 = league1.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league1.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)

    visit "/leagues/#{league1.id}"

    expect(page).to have_link("Delete league")
    click_link("Delete league")
    expect(current_path).to eq("/leagues")

    expect(page).to have_content("MLS")
    expect(page).to_not have_content("Serie A")
  end
end