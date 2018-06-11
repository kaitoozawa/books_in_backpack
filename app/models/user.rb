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
  has_many :relationshipmessages
  has_many :m_requestings, through: :relationshipmessages, source: :m_request
  has_many :reverses_of_relationshipmessage, class_name: 'Relationshipmessage', foreign_key: 'm_request_id'
  has_many :m_requesteds, through: :reverses_of_relationshipmessage, source: :user
  has_many :messages
  
  # For request & unrequest button
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
    if self.requestings.include?(other_user) && self.requesteds.include?(other_user)
      return true
    else
      return false
    end
  end
  
  def request_exist?(other_user)
    self.requestings.include?(other_user)
  end
  
  # For Message button
  def m_send_request(other_user)
    unless self == other_user
      self.relationshipmessages.find_or_create_by(m_request_id: other_user.id)
    end
  end
  
  def m_match_exist?(other_user)
    if self.m_requestings.include?(other_user) && self.m_requesteds.include?(other_user)
      return true
    else
      return false
    end
  end
  
  def m_requestings_exist?(other_user)
    self.m_requestings.include?(other_user)
  end
  
  #implementation after message button is pushed
  def go_to_message(other_user)
    self.update(message_user_id: other_user.id)
    others = []
    other_relationships = self.relationshipmessages.where(user_id: self.id)
    other_relationships.each do |other|
      unless other.m_request_id == other_user.id
        others << other
      end
    end
    others.each do |other|
      other.destroy
    end
  end
  
  def send_message(other_user, content)
    unless self == other_user
      self.messages.build(recipient_id: other_user.id, content: content)
    end
  end
  
  def message_user_exist?(other_user)
    if self.message_user_id.present? && self.message_user_id == other_user.id
      return true
    else
      return false
    end
  end
end