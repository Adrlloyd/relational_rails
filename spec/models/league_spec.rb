require 'rails_helper'

RSpec.describe League do
  it {should have_many :clubs}
end