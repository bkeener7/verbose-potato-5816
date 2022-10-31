Rails.application.routes.draw do
  # customers
  get 'customers/:id', to: 'customers#show'

  # items
  patch '/items/add_customer', to: 'items#add_customer'
end
