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
end