require 'rails_helper'


feature 'restaurants' do

  before do
    visit '/'
    click_link 'Sign up'
    fill_in 'Email', with: "samed@hotmail.de"
    fill_in 'Password', with: "1234abc"
    fill_in 'Password confirmation', with: "1234abc"
    click_button ('Sign up')
  end

  context 'no restaurants have been added' do

    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added'do
    before do
      Restaurant.create(name: 'KFC',description: 'Fast Food')
    end

    scenario 'display restaurants'do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end

  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      expect(current_path).to eq '/restaurants/new'
      fill_in 'Name', with: 'KFC'
      fill_in 'Description', with: 'Fast Food'
      click_button 'Create Restaurant'
      expect(page).to have_content("KFC")
      expect(current_path).to eq '/restaurants'

    end
  end

  context'an invalid restaurant' do
    it 'does not let you submit a name that is too short' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end

  context 'viewing restaurants' do
    let!(:kfc){ Restaurant.create(name: 'KFC', description: "Fast Food") }
    scenario 'lets a user view a restaurant' do
    visit '/restaurants'
    click_link 'KFC'
    expect(page).to have_content 'KFC'
    expect(page).to have_content 'Fast Food'
    expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
      scenario 'user can edit his own restaurant' do
        click_link 'Sign out'
        sign_up_and_add_restaurant
        edit_restaurant
        expect(page).to have_content 'Kentucky Fried Chicken'
        expect(current_path).to eq '/restaurants'
      end
      scenario 'user cannot edit restaurants he did not create' do
        add_restaurant
        click_link 'Sign out'
        sign_up
        expect(page).not_to have_content("Edit KFC")
      end
  end

  context 'deleting restaurants' do
    scenario 'user can delete his own restaurant' do
      click_link 'Sign out'
      sign_up_and_add_restaurant
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
      expect(current_path).to eq '/restaurants'
    end
    scenario 'user cannot delete restaurants he did not create' do
      add_restaurant
      click_link 'Sign out'
      sign_up
      expect(page).not_to have_content("Delete KFC")
    end
  end



end
