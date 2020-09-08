class Tagging < ApplicationRecord
  belongs_to :term
  belongs_to :tag
end
