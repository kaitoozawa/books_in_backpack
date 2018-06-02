class Book < ApplicationRecord
  validates :image, presence: true
  validates :title, presence: true, length: { maximum: 50 }
  validates :author, presence: true, length: { maximum: 50 }
  validates :language, presence: true, length: { maximum: 50 }
  validates :page, presence: true
  validates :description, presence: true, length: { maximum: 255 }
  
  mount_uploader :image, ImageUploader
  
  belongs_to :user
end
