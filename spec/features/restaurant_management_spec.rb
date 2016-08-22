require 'rails_helper'

feature 'Restaurant management' do
  scenario 'Visitor can create a new restaurant listing' do
    visit '/restaurants/new'
    fill_in "restaurant[name]", with: "Okini"
    fill_in "restaurant[description]", with:"Awesome"
    click_button "Save Restaurant"
    expect(page).to have_content("Okini")
    expect(page).to have_content("Awesome")



  end
end
