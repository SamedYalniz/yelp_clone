def sign_up(email = "s.yalniz@hotmail.de", password = "123456")
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  fill_in 'Password confirmation', with: password
  click_button 'Sign up'
end

def sign_up_and_add_restaurant
  sign_up
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'KFC'
  click_button 'Create Restaurant'
end

def edit_restaurant
  click_link 'Edit KFC'
  fill_in 'Name', with: 'Kentucky Fried Chicken'
  fill_in 'Description', with: "deep fried goodness"
  click_button 'Update Restaurant'
end

def add_restaurant
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'KFC'
  click_button 'Create Restaurant'
end
