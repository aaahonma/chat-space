class Message < ApplicationRecord
    belongs_to :user
    belongs_to :group

    validates :content, presence: true, unless: :image?
    # presence: true=空白NG
    # imageカラムに値があった場合

    # 画像アップロードに必要な記述
    mount_uploader :image, ImageUploader
end
