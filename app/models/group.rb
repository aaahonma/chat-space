class Group < ApplicationRecord
    has_many :messages
    has_many :users, through: :group_users
    has_many :group_users, dependent: :destroy

    validates :name, presence: true, uniqueness: true  #追記バリデーション設定(nameカラムは空白なし、重複なし)

    def show_last_message  # インスタンスメソッド、messages.lastで各インスタンスごとの最後に生成したメッセージ内容を取得する
        if (last_message = messages.last).present?  # 最後のメッセージが存在するかチェック
            # 存在する。なおかつ
            last_message.content? ? last_message.content : '画像が投稿されています'
            # 三項演算子 「条件式 ? trueの時の値 : falseの時の値」
            # 条件式：最後のメッセージのcontentカラムに値があるか？　trueならcontentカラムを渡す、falseなら「画像が投稿されています」を渡す
        else
            # 存在しない処理
            'まだメッセージはありません'
        end
    end
end
