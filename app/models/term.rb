class Term < ApplicationRecord
  belongs_to :user
  belongs_to :genre, optional: true
end
