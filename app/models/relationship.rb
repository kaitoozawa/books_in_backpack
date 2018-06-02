class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :request, class_name: 'User'
  
  validates :user_id, presence: true
  validates :request_id, presence: true
end
