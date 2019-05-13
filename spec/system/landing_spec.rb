require 'rails_helper'

describe 'Landing', type: :system do
  it 'see the call to action' do
    visit '/'

    expect(page).to have_content('Play Now!')
  end
end
