class Profile < ApplicationRecord
  validates :image, presence: true
  validates :name, presence: true, length: { maximum: 50 }
  validates :nationality, presence: true, length: { maximum: 50 }
  validates :gender, presence: true, length: { maximum: 50 }
  validates :age, presence: true
  validates :description, presence: true, length: { maximum: 255 }
  
  mount_uploader :image, ImageUploader
  
  belongs_to :user
end
