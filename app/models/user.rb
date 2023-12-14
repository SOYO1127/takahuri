class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         mount_uploader :image, ImageUploader

         has_many :posts
         has_many :likes, dependent: :destroy
         has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_many :posts, dependent: :destroy #追記 ユーザーが削除されたら、ツイートも削除されるようになります。すでに書いてある場合は追記しなくて大丈夫です。
  validates :name, presence: true #追記
  validates :profile, length: { maximum: 200 } #追記

  def already_liked?(post)
    self.likes.exists?(post_id: post.id)
  end
end
