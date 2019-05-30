class Group < ApplicationRecord
    has_many :users, through: :group_users
    has_many :group_users, dependent: :destroy

    validates :name, presence: true, uniqueness: true  #追記バリデーション設定(nameカラムは空白なし、重複なし)
end
