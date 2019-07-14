class UsersController < ApplicationController
    def index
        @users = User.where('nickname LIKE(?)', "%#{params[:nickname]}%").where.not(id: current_user.id)
        # .where.not(nickname: current_user.nickname)= 自分のユーザーデータのみDBより取得除外する
        respond_to do |format|
            format.html
            format.json
            # index.json.jbuilderファイルを読み込む
            # jbuilderファイルによって返されるjsonデータはindex.jsファイルに渡される
        end
    end

    def edit
    end

    def update
    end
end
