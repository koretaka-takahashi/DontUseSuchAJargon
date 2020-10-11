class Description < ApplicationRecord
  belongs_to :user
  belongs_to :term
  has_many :comments, dependent: :destroy

  validates :content, presence: true, length: { maximum: 1000 }
end
