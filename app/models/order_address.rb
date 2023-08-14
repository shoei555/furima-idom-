class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :mailing_address, :house_number, :building_name, :phone_number,:item_id, :user_id, :token

  with_options presence: true do
    validates :token
    validates :post_code,         format: { with: /\A\d{3}[-]?\d{4}\z/, message: 'is invalid. Enter it as follows(e.g. 123-4567)' }
    validates :prefecture_id,     numericality: { other_than: 1 , message: "can't be blank"} 
    validates :mailing_address
    validates :house_number
    validates :phone_number,      length: { minimum: 10, maximum: 11 },numericality: {only_integer: true}
    validates :item_id
    validates :user_id
  end

  def save
    # オーダー情報を保存し、変数orderに代入する
    order = Order.create(item_id: item_id, user_id: user_id)
    # 住所を保存する
    # order_idには、変数orderのidと指定する
    Address.create(post_code: post_code, prefecture_id: prefecture_id, mailing_address: mailing_address, house_number: house_number, building_name: building_name, phone_number: phone_number ,order_id: order.id)
  end
end