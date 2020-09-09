class Tag < ApplicationRecord
  belongs_to :genre
  belongs_to :user
  has_many :taggings, dependent: :destroy
  has_many :terms, through: :taggings
end
