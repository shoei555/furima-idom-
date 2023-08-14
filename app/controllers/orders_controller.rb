class OrdersController < ApplicationController
  before_action :set_item, only: [:index, :create]

  # 注文情報入力ページの表示
  def index
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
    if !user_signed_in? || @item.user_id == current_user.id || Order.exists?( item_id: @item.id)
      redirect_to root_path
    else
      @order_address = OrderAddress.new
    end
  end

  # 注文の作成と支払い処理
  def create
    
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      # ルートページへリダイレクト
      redirect_to root_path
    else
      # 入力エラーがある場合は注文情報入力ページを表示
      render 'index', status: :unprocessable_entity
    end
  end

  private
  # 注文のパラメータを取得
  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :mailing_address, :house_number, :building_name, :phone_number).merge(item_id: @item.id ,user_id: current_user.id, token: params[:token])
  end

  # def address_params
  #   params.permit(:post_code, :prefecture_id, :mailing_address, :house_number, :building_name, :phone_number).merge(order_id: @order.id)
  # end

  # 商品の情報を取得
  def set_item
    @item = Item.find(params[:item_id])
  end

  # 商品の支払い処理
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price,  # 商品の値段
      card: order_params[:token],    # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end

end
