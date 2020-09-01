class Description < ApplicationRecord
  belongs_to :user
  belongs_to :term

  validates :content, presence: true, length: { maximum: 1000 }
end
