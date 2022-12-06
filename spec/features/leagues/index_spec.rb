require 'rails_helper'

RSpec.describe 'leagues index' do 
#   User Story 1, Parent Index 

# For each parent table
# As a visitor
# When I visit '/parents'
# Then I see the name of each parent record in the system

  it 'displays the name of each league' do
    league1 = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    league2 = League.create!(name: 'MLS', level: 1, country: 'USA', relegation: false)

    visit '/leagues'

    expect(page).to have_content(league1.name)
    expect(page).to have_content(league2.name)
    expect(page).to_not have_content(league1.country)
  end

# User Story 6, Parent Index sorted by Most Recently Created 

# As a visitor
# When I visit the parent index,
# I see that records are ordered by most recently created first
# And next to each of the records I see when it was created
  it 'lists the leagues by most recently created' do
    league1 = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true, created_at: Time.now - 2.days)
    league2 = League.create!(name: 'MLS', level: 1, country: 'USA', relegation: false)

    visit '/leagues'
    
    expect(league2.name).to appear_before(league1.name)
    expect(page).to have_content(league1.name)
    expect(page).to have_content(league2.name)
  end

# User Story 9, Parent Index Link

# As a visitor
# When I visit any page on the site
# Then I see a link at the top of the page that takes me to the Parent Index
  it 'has a link on every page to the Leagues index' do
    league = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    league2 = League.create!(name: 'MLS', level: 1, country: 'USA', relegation: false)
    club1 = league.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)

    visit '/clubs'
    
    expect(page).to have_link("Leagues Index")
    click_link("Leagues Index")
    expect(current_path).to eq("/leagues")
  end

# User Story 11, Parent Creation 

# As a visitor
# When I visit the Parent Index page
# Then I see a link to create a new Parent record, "New Parent"
# When I click this link
# Then I am taken to '/parents/new' where I  see a form for a new parent record
# When I fill out the form with a new parent's attributes:
# And I click the button "Create Parent" to submit the form
# Then a `POST` request is sent to the '/parents' route,
# a new parent record is created,
# and I am redirected to the Parent Index page where I see the new Parent displayed.
  it 'can create a new League' do
    league = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    club1 = league.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)

    visit '/leagues'

    expect(page).to have_link("New League")
    click_link("New League")
    expect(current_path).to eq("/leagues/new")

    fill_in :name, with: "MLS"
    fill_in :level, with: 1
    fill_in :country, with: "USA"
    select "false", :from => "relegation"

    click_button("Submit")
    expect(current_path).to eq("/leagues")
  end

# User Story 17, Parent Update From Parent Index Page 

# As a visitor
# When I visit the parent index page
# Next to every parent, I see a link to edit that parent's info
# When I click the link
# I should be taken to that parent's edit page where I can update its information just like in User Story 12
  it 'has a link to edit the league next to each league/name' do
    league1 = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    league2 = League.create!(name: 'MLS', level: 1, country: 'USA', relegation: false)
    club1 = league1.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league1.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)
    club3 = league2.clubs.create!(name: 'Colorado Rapids', position: 2, city: 'Denver', previous_winner: true)

    visit '/leagues'
    
    expect(page).to have_link("Edit")
    first(:link, "Edit").click
    expect(current_path).to eq("/leagues/#{league2.id}/edit")
  end

# User Story 22, Parent Delete From Parent Index Page 

# As a visitor
# When I visit the parent index page
# Next to every parent, I see a link to delete that parent
# When I click the link
# I am returned to the Parent Index Page where I no longer see that parent.
  it 'has a delete link for every league' do
    league1 = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    league2 = League.create!(name: 'MLS', level: 1, country: 'USA', relegation: false)
    club1 = league1.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league1.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)
    club3 = league2.clubs.create!(name: 'Colorado Rapids', position: 2, city: 'Denver', previous_winner: true)

    visit '/leagues'

    expect(page).to have_link("Delete")
    first(:link, "Delete").click
    expect(current_path).to eq("/leagues")
        
    expect(page).to have_content(league1.name)
    expect(page).to_not have_content(league2.name)
  end
end