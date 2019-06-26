class UsersController < ApplicationController
    def index
        @users = User.where('nickname LIKE(?)', "%#{params[:nickname]}%").where.not(nickname: current_user.nickname).limit(10)
        # .where.not(nickname: current_user.nickname)= 自分のユーザーデータのみDBより取得除外する
        respond_to do |users|
            users.html
            users.json
            # index.json.jbuilderファイルを読み込む
            # jbuilderファイルによって返されるjsonデータはindex.jsファイルに渡される
        end
    end

    def edit
    end

    def update
    end
end
