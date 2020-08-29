class Term < ApplicationRecord
  belongs_to :user
  belongs_to :genre, optional: true

  validates :name, presence: true, length: { maximum: 50 }
end
