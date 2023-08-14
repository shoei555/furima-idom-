class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show, :edit]

  def index
    @items = Item.all.order("created_at DESC")
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
# unprocessable_entity」が、発生したエラーの種類を示すもので、「何らかの処理に失敗した」という汎用的な指定方法になります
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    if user_signed_in? && @item.user_id == current_user.id && Order.exists?(item_id: @item.id)
      redirect_to root_path
    elsif user_signed_in? && @item.user_id == current_user.id

    elsif user_signed_in?
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy 
    item = Item.find(params[:id])
    item.destroy
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :item_summary, 
    :item_category_id, :item_condition_id, :shipping_cost_id,
    :prefecture_id, :day_to_shipment_id, :price).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
