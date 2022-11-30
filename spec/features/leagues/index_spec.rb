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
end