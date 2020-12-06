class User < ApplicationRecord
  has_many :terms, dependent: :nullify
  has_many :descriptions # これもdependent: :destroy は無くていい
  has_many :tags # これもdependent: :destroy は無くていい
  has_many :comments # これもdependent: :destroy は無くていい
  has_many :likes, dependent: :destroy
  has_many :keeps, dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 100 }
  validates :profile, length: { maximum: 1500 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :image, ImageUploader
  
  # いいね！しているか否か
  def already_liked?(description)
    self.likes.exists?(description_id: description.id)
  end

  # キープしているか否か
  def already_keeped?(term)
    self.keeps.exists?(term_id: term.id)
  end
end
