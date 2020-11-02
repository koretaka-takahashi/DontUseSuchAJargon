class Keep < ApplicationRecord
  belongs_to :user
  belongs_to :term
  # 同じTermを複数回お気に入り登録させない。
  validates_uniqueness_of :term_id, scope: :user_id
end
