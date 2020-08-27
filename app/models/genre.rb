class Genre < ApplicationRecord
  has_many :terms # dependent: :destroy は無くていいと踏んでいる
end
