class Item < ApplicationRecord
  belongs_to :user
  has_one :order
  has_one_attached :image


  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :item_category
  belongs_to :item_condition
  belongs_to :shipping_cost
  belongs_to :prefecture
  belongs_to :day_to_shipment

  validates :item_name,         presence: true
  validates :item_summary,      presence: true
  validates :image,             presence: true, blob: { content_type: :image }
  validates :price,             presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 300,less_than_or_equal_to: 9999999}
  validates :item_category_id,  numericality: { other_than: 1 , message: "can't be blank"} 
  validates :item_condition_id, numericality: { other_than: 1 , message: "can't be blank"} 
  validates :shipping_cost_id,  numericality: { other_than: 1 , message: "can't be blank"} 
  validates :prefecture_id,     numericality: { other_than: 1 , message: "can't be blank"} 
  validates :day_to_shipment_id,numericality: { other_than: 1 , message: "can't be blank"} 
end
