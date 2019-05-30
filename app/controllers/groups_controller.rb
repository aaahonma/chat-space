class GroupsController < ApplicationController
    before_action :set_group, only: [:edit, :update]

    def index
    end

    def new
        @group = Group.new
        @group.users << current_user  #新規作成したgroupにログイン中のユーザーを追加
    end

    def create
        @group = Group.new(group_params)  #＠group変数はnewメソッドで作成されたログインユーザーが追加されたgroup
        if @group.save
            redirect_to root_path, notice: 'グループを作成しました'  #正常にセーブできた際はrootパスに戻ってnotice属性に指定文章を渡す
        else
            render :new  #セーブに失敗した時は再度newメソッドの実装
        end
    end

    def edit
        # form_forメソッドにて使用する@group変数を定義が必要
        # ↑set_groupメソッドにて@groupを定義している
    end

    def update
        if @group.update(group_params)
            redirect_to group_messages_path(@group), notice: 'グループを編集しました'
        else
            render :edit
        end
    end

    private

    def group_params
        params.require(:group).permit(:name, {:user_ids => [] })
        #require=渡されるparamsのオブジェクトを絞る(user,action,controllerなど)
        #permit=オブジェクト別に渡される値をさらに絞る
        #:user_idはgroupに所属するメンバー一覧配列
    end

    def set_group
        @group = Group.find(params[:id])
        #findで(params)で渡している:idはグループid
    end
end
