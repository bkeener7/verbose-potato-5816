class CustomerBasketController < ApplicationController
  def add_customer
    CustomerBasket.create!(item_id: params[:item_id], customer_id: params[:customer_id])
    redirect_to "/customers/#{params[:customer_id]}"
  end
end
