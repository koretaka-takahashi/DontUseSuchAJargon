class Term < ApplicationRecord
  belongs_to :user
  belongs_to :genre, optional: true
  has_many :terms, dependent: :destroy
  has_many :descriptions, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates :name, presence: true, length: { maximum: 50 }
end
