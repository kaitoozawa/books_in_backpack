class Trade2 < ApplicationRecord
  belongs_to :user
  belongs_to :trader, class_name: 'User'
  
  validates :user_id, presence: true
  validates :trader_id, presence: true
end
