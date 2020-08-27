class User < ApplicationRecord
  has_many :terms # dependent: :destroy は無くていいと踏んでいる
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
