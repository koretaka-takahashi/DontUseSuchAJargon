class Genre < ApplicationRecord
  has_many :terms # dependent: :destroy は無くていいと踏んでいる
  has_many :terms, dependent: :destroy
  has_many :tags, dependent: :destroy
  validates :name, presence: true, uniqueness: true, length: { maximum: 50 }
  mount_uploader :image, ImageUploader
end
