class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :timeoutable
  # user          投稿はできる自分の投稿以外は編集できない
  # contributor   他人の投稿も編集できる
  # editor        ゲームを投稿できる
  # admin         ユーザー権限を設定できる
  enum role: { user: 0, contributor: 1, editor: 4, admin: 5 }
  validates :name, presence: true, length: { maximum: 50 }

  def self.find_for_google(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(provider: auth.provider,
                         email:    User.dummy_email(auth),
                         image:    auth.info.image,
                         uid:      auth.uid,
                         token:    auth.credentials.token,
                         password: Devise.friendly_token[0, 20],
                         name: auth.info.name)
    end
    user
  end

  private
    def self.dummy_email(auth)
      "#{auth.uid}-#{auth.provider}@omniauthable.com"
    end
end
