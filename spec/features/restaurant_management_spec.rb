require 'rails_helper'


feature 'Restaurant management' do
  scenario 'Visitor can create a new restaurant listing' do
    visit '/restaurants/new'
    fill_in "restaurant[name]", with: "Okini"
    fill_in "restaurant[description]", with:"Awesome"
    click_button "Save Restaurant"
    expect(page).to have_content("Okini")
    expect(page).to have_content("Awesome")
    expect(Restaurant.count).to eq 1
  end
  scenario('User can see a listing of restaurants') do
    create_restaurant("Naguya", "Awesome")
    create_restaurant("Okini", "Delicious")
    expect(Restaurant.count).to eq 2
    visit '/restaurants'
    expect(page).to have_content("Naguya")
    expect(page).to have_content("Awesome")
    expect(page).to have_content("Okini")
    expect(page).to have_content("Delicious")
  end
  scenario ('User cannot create a restaurant without name') do
    visit '/restaurants/new'
    fill_in "restaurant[description]", with: "Awesome"
    click_button "Save Restaurant"
    expect(Restaurant.count).to eq 0
    within 'div#error_explanation' do
      expect(page).to have_content("Name can't be blank")
    end
  end

end
