class Tag < ApplicationRecord
  belongs_to :genre
  has_many :taggings, dependent: :destroy
  has_many :terms, through: :taggings
end
