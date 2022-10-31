class ItemsController < ApplicationController
  def add_customer
    @item = Item.find(params[:item_id])
    @updated_item = @item.update(items_params)
    redirect_to "/customers/#{params[:customer_id]}"
  end

  private

  def items_params
    params.permit(:customer_id)
  end
end
