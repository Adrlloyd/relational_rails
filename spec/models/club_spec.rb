require 'rails_helper'

RSpec.describe Club do
  it {should belong_to :league}
end