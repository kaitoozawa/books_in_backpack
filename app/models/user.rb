class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  belongs_to :mylocation, optional: true
  has_one :book
  has_one :profile
  has_many :relationships
  has_many :requestings, through: :relationships, source: :request
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'request_id'
  has_many :requesteds, through: :reverses_of_relationship, source: :user
  
  def send_request(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(request_id: other_user.id)
    end
  end
  
  def cancel_request(other_user)
    relationship = self.relationships.find_by(request_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def match_exist?(other_user)
    if self.requestings.include(other_user) && self.requested.include?(other_user)
      return true
    else
      return false
    end
  end
  
  def request_exist?(other_user)
    self.requestings.include?(other_user)
  end
end