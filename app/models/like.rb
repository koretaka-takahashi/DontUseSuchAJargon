class Like < ApplicationRecord
  belongs_to :user
  belongs_to :description
  # 同じ解説を複数回お気に入り登録させない。
  validates_uniqueness_of :description_id, scope: :user_id
end
