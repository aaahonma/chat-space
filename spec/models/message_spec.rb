require 'rails_helper'
# rails_helperファイルに記述されている共通の設定を読み込む
# require 'rails_helper'の記述は全specファイルに記述が必要
RSpec.describe Message, type: :model do
    describe '#create' do  #ネストすることにより、Messageクラスのindexメソッドに対してテストを行う　メソッド名の接頭に＃をつけるのは慣習
        # 正常にセーブできるパターンをテスト
        context 'can save' do  # context= 特定の条件下のテストをグループにしたい時に使う
            # 本文さえあれば保存できるかどうか
            it 'is valid with content' do
                expect(build(:message, image: nil)).to be_valid
            end
            # 画像さえあれば保存できるかどうか
            it 'is valid with image' do
                expect(build(:message, content: nil)).to be_valid
            end

            # 本文と画像があれば保存できるかどうか
            it 'is valid with content and image' do
                expect(build(:message)).to be_valid
            end
        end

        # セーブができなかったパターンをテスト
        context 'can not save' do
            # 本文も画像もnilだった場合
            it 'is invalid without content and image' do
                message = build(:message, content: nil, image: nil)
                message.valid?
                expect(message.errors[:content]).to include('を入力してください')
            end
            # group_idがnilだった場合
            it 'is invalid without group_id' do
                message = build(:message, group_id: nil)  # 外部キー〇〇_idに対してnilを指定するが、errorsで検知する対象は:group
                message.valid?
                expect(message.errors[:group]).to include('を入力してください')
            end
            # group_idがnilだった場合
            it 'is invalid without user_id' do
                message = build(:message, user_id: nil)
                message.valid?
                expect(message.errors[:user]).to include('を入力してください')
            end
        end
    end
end
