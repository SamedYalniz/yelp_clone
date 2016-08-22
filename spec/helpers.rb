def create_restaurant(name,description)
  restaurant = Restaurant.new(name: name,description: description)
  restaurant.save
end
