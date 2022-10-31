Rails.application.routes.draw do
  # customers
  get 'customers/:id', to: 'customers#show'
end
