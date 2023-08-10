# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# README

# Furima テーブル設計


##users

| Column             | Type   | Options                   |
|------------------- | ------ | --------------------------|
|nick_name           |string  |null:false                 |
|email               |string  |null:false,unique: true    |
|encrypted_password  |string  |null:false                 |
|kanji_first_name    |string  |null:false                 |
|kanji_last_name     |string  |null:false                 |
|kana_first_name     |string  |null:false                 |
|kana_last_name      |string  |null:false                 |
|birthday_yyyy_mm_dd |date    |null:false                 |



###Associations

-has_many :items
-has_many :orders


##items

| Column             | Type        | Options                    |
| ------------------ | ------------| ---------------------------|
|user                | references  |null:false,foreign_key :true|
|item_name           | string      |null: false                 |
|item_summary        | text        |null: false                 |
|item_category_id    | integer     |null: false                 |
|item_condition_id   | integer     |null:false                  |
|shipping_cost_id    | integer     |null: false                 |
|prefecture_id       | integer     |null:false                  |
|day_to_shipment_id  | integer     |null: false                 |
|price               | integer     |null: false                 |

###Association

-belongs_to :user
-has_one :order
- belongs_to_active_hash :item_category_id
- belongs_to_active_hash :item_condition_id
- belongs_to_active_hash :shipping_cost_id
- belongs_to_active_hash :prefecture_id
- belongs_to_active_hash :day_to_shipment_id


##orders

| Column             | Type        | Options                      |
| ------------------ | ------------| -----------------------------|
|user                |references   | null: false,foreign_key: true|
|item                |references   | null: false,foreign_key: true|

###Assosiation

-belongs_to :user
-belongs_to :item
-has_one :address

##addresses

| Column             | Type        | Options                            |
| ------------------ | ------------|------------------------------------|
|post_code           | string      |null: false                         |
|prefecture_id       | integer     |null:false                          |
|mailing_address     | string      |null: false                         |
|house_number        | string      |null: false                         |
|building_name       | string      |                                    |
|phone_number        | string      |null: false                         |
|order               | references  |null: false,foreign_key: true       |

###Association

-has_one_active_hash :prefecture_id
-belongs_to :order