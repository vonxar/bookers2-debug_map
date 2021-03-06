class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable
         
  has_many :favorite_book, through: :favorites, source: :book
  has_many :books, dependent: :destroy
  has_many :book_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following,through: :active_relationships,source: :followed
  has_many :followers,through: :passive_relationships,source: :follower
  attachment :profile_image, destroy: false
  validates :name, presence:true
  
  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
  
# def self.search(search)
#       if search
#         where(['name LIKE ?', "%#{search}%"])
#       else
        
#       end
# end
 
def User.search(search, user_or_book, how_search)
    if user_or_book == "1"
      if how_search == "1"
           User.where(['name LIKE ?', "%#{search}%"])
      elsif how_search == "2"
            User.where(['name LIKE ?', "%#{search}"])
      elsif how_search == "3"
            User.where(['name LIKE ?', "#{search}%"])
      elsif how_search == "4"
            User.where(['name LIKE ?', "#{search}"])
      else
            User.all
      end
    end
end

 include JpPrefecture
  jp_prefecture :prefecture_code
  
  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
 
  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
end
