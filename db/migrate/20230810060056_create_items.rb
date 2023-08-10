class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.references :user,                  null: false, foreign_key: true
      t.string     :item_name,             null: false
      t.text       :item_summary,          null: false
      t.integer    :item_category_id,      null: false
      t.integer    :item_condition_id,     null: false
      t.integer    :shipping_cost_id,      null: false
      t.integer    :prefecture_id,         null: false
      t.integer    :day_to_shipment_id,    null: false
      t.integer    :price,                 null: false
      t.timestamps
    end
  end
end
