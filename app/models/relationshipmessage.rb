class Relationshipmessage < ApplicationRecord
  belongs_to :user
  belongs_to :m_request, class_name: 'User'
  
  validates :user_id, presence: true
  validates :m_request_id, presence: true
end
