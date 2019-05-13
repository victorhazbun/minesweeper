require 'rails_helper'

describe 'Login', type: :system, js: true do
  let(:password) { 'password' }
  let(:user) { create(:user, password: password) }

  it 'see the game page' do
    visit '/login'

    fill_in 'Email', with: user.email
    fill_in 'Password', with: password

    click_button 'LOG IN'

    expect(page).to have_current_path('/game/new')
    expect(page).to have_content('New game')
  end
end
