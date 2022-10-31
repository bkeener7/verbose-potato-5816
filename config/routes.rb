Rails.application.routes.draw do
  # default
  get '/', to: 'items#index'

  # customers
  get '/customers/:id', to: 'customers#show'

  # items
  get '/items', to: 'items#index'

  # customer_basket
  post '/customer_basket/add_customer', to: 'customer_basket#add_customer'
end
