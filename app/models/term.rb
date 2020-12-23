class Term < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :genre, optional: true
  has_many :descriptions, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_many :keeps, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
end
