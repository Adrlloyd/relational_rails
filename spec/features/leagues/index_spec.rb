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
end