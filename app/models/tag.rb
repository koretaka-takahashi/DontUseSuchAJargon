class Tag < ApplicationRecord
  belongs_to :genre
  belongs_to :user, optional: true
  has_many :taggings, dependent: :destroy
  has_many :terms, through: :taggings
  validates :name, presence: true, length: { maximum: 50 }
end
