class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_error_message

  def index 
    if params[:user_id]
      user = User.find(params[:user_id])
      item = user.items
    else
      item = Item.all
    end
    render json: item, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item
  end

  def create
      user = User.find(params[:user_id])
      item = user.items.create(item_params)
      render json: item, status: 201
  
  end

 

  private 

  def render_error_message
    render json: { error: "User not found" }, status: :not_found
  end

  def item_params
    params.permit(:name, :description, :price)
  end

end
