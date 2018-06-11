class Message < ApplicationRecord
  belongs_to :user
  belongs_to :recipient, class_name: 'User'
  
  validates :user_id, presence: true
  validates :recipient_id, presence: true
  validates :content, presence: true, length: { maximum: 50 }
end