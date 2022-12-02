require 'rails_helper'

RSpec.describe 'clubs index' do 
  # User Story 3, Child Index 

  # As a visitor
  # When I visit '/child_table_name'
  # Then I see each Child in the system including the Child's attributes
  # (data from each column that is on the child table)

  it 'displays the name of each club' do
    league = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    club1 = league.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)

    visit '/clubs'

    expect(page).to have_content(club1.name)
    expect(page).to have_content(club2.name)
    expect(page).to_not have_content(league.country)
  end

  it 'displays the position of each club' do
    league = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    club1 = league.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)

    visit '/clubs'

    expect(page).to have_content(club1.position)
    expect(page).to have_content(club2.position)
    expect(page).to_not have_content(league.country)
  end

  it 'displays the city of each club' do
    league = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    club1 = league.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)

    visit '/clubs'

    expect(page).to have_content(club1.city)
    expect(page).to have_content(club2.city)
    expect(page).to_not have_content(league.country)
  end

  it 'displays if the club has previous won the league of each club' do
    league = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    club1 = league.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)

    visit '/clubs'
    
    expect(page).to have_content(club1.previous_winner)
    expect(page).to have_content(club2.previous_winner)
    expect(page).to_not have_content(league.country)
  end

# User Story 8, Child Index Link

# As a visitor
# When I visit any page on the site
# Then I see a link at the top of the page that takes me to the Child Index

  it 'has a link on every page to the clubs index' do
    league = League.create!(name: 'Serie A', level: 1, country: 'Italy', relegation: true)
    club1 = league.clubs.create!(name: 'AS Roma', position: 1, city: 'Rome', previous_winner: true)
    club2 = league.clubs.create!(name: 'Juventus', position: 2, city: 'Turin', previous_winner: true)

    visit '/leagues'
    
    expect(page).to have_link("Clubs Index")
    click_link("Clubs Index")
    expect(current_path).to eq("/clubs")
  end
end