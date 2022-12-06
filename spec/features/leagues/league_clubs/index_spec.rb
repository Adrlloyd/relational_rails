require 'rails_helper'

RSpec.describe 'league_clubs index' do 
  # User Story 10, Parent Children Index 

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

# User Story 13, Parent Child Creation 

# As a visitor
# When I visit a Parent Children Index page
# Then I see a link to add a new adoptable child for that parent "Create Child"
# When I click the link
# I am taken to '/parents/:parent_id/child_table_name/new' where I see a form to add a new adoptable child
# When I fill in the form with the child's attributes:
# And I click the button "Create Child"
# Then a `POST` request is sent to '/parents/:parent_id/child_table_name',
# a new child object/row is created for that parent,
# and I am redirected to the Parent Childs Index page where I can see the new child listed

  it 'can create a new club for the specific league' do
    league1 = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    club1 = league1.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league1.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)

    visit "/leagues/#{league1.id}/clubs"

    expect(page).to have_link("Create new club")
    click_link("Create new club")
    expect(current_path).to eq("/leagues/#{league1.id}/clubs/new")

    fill_in :name, with: "AC Milan"
    fill_in :position, with: 3
    fill_in :city, with: "Milan"
    select "true", :from => "previous_winner"

    click_button('Create club')
    expect(current_path).to eq("/leagues/#{league1.id}/clubs")
    expect(page).to have_content("AC Milan")
  end

# User Story 16, Sort Parent's Children in Alphabetical Order by name 

# As a visitor
# When I visit the Parent's children Index Page
# Then I see a link to sort children in alphabetical order
# When I click on the link
# I'm taken back to the Parent's children Index Page where I see all of the parent's children in alphabetical order
  it 'sorts clubs alphabetically when the link is clicked' do
    league1 = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    club1 = league1.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league1.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)
    club3 = league1.clubs.create!(name: 'AC Monza', position: 13, city: 'Monza', previous_winner: false)
    club4 = league1.clubs.create!(name: 'Inter Milan', position: 3, city: 'Milan', previous_winner: true)

    visit "/leagues/#{league1.id}/clubs"
    
    expect(page).to have_link("Sort Alphabetically")
    expect(club1.name).to appear_before(club2.name)
    expect(club2.name).to appear_before(club3.name)
    expect(club3.name).to appear_before(club4.name)
    #expecting them to start in created order.
    
    click_link("Sort Alphabetically")
    expect(current_path).to eq("/leagues/#{league1.id}/clubs")
    
    expect(club3.name).to appear_before(club1.name)
    expect(club1.name).to appear_before(club4.name)
    expect(club4.name).to appear_before(club2.name)
  end
end