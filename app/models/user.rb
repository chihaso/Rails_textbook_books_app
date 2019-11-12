# frozen_string_literal: true

class User < ApplicationRecord
  has_one_attached :avatar
  has_many :active_relationships, foreign_key: "follower_id", class_name: "Follow", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followee
  has_many :passive_relationships, foreign_key: "followee_id", class_name: "Follow", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :posts, foreign_key: "user_id", class_name: "Book"
  has_many :reports, foreign_key: "user_id", class_name: "Report"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable

  def follow(other_user)
    active_relationships.create(followee_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followee_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  # 入力された認証情報からDBに登録されたユーザーをさがしてUserクラスのオブジェクトとして返す(見つからなければ新規に登録)
  def self.find_for_oauth(auth) # selfつきなのでクラスメソッド authに入るのはrequest.env['omniauth.auth']
    user = User.where(uid: auth.uid, provider: auth.provider).first # whereメソッドはDBから条件に当てはまるレコードを全て取得

    unless user # 存在しないuserなら、新規に登録
      user = User.create(
        uid:  auth.uid,
        provider: auth.provider,
        email: User.dummy_email(auth), # 下記で定義 仮メールアドレス生成
        password: Devise.friendly_token[0, 20] # ランダムな文字列のトークンを発行
      )
    end

    user
  end

  private
    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@example.com"
    end
end
