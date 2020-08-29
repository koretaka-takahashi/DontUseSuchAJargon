class Genre < ApplicationRecord
  has_many :terms # dependent: :destroy は無くていいと踏んでいる

  validates :name, presence: true, length: { maximum: 50 }
end
