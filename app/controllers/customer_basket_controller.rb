class CustomerBasketController < ApplicationController
  def add_customer
    item = Item.find(params[:item_id])
    CustomerBasket.create!(item_id: item.id, customer_id: params[:customer_id])
    redirect_to "/customers/#{params[:customer_id]}"
  end
end
