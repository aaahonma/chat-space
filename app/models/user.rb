class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages
  has_many :groups, through: :group_users
  has_many :group_users, dependent: :destroy  #userが破棄された際はuserに関連するgroup_userも破棄

  accepts_nested_attributes_for :group_users, allow_destroy: true  #関連項目も含めて一度に削除、保存する
end
