class Description < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :term
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :content, presence: true, length: { maximum: 1000 }
end
