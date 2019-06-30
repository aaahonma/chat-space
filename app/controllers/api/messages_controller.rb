class Api::MessagesController < ApplicationController
    # ::= 名前空間 or namespaceという。クラス名を繋げることで装飾が可能
    # apiフォルダのMessagesControllerとして区別できる

    before_action :set_group # 全てのアクション内で@group変数を使えるようにする

    def index
        @messages = @group.messages.all

        respond_to do |users|
            # users.html　# html形式でアクセスがあった場合は特に何もなし(@messagesして終わり）
            users.json {@new_messages = @group.messages.includes(:user).where('id > ?', params[:id] )}
            # 必ずjson形式のデータを受け取ってからテーブルから検索をかける必要がある。respond_to外に記述するとparamsが送られて来なくエラーが起こる,paramsが送られてくるタイミングはreloadMessages関数を実行したとき。
            # json形式でアクセスがあった場合は、params[:id]よりも大きいidがないかMessageから検索して、@new_messageに代入する
            # @grooup= 現在所属しているグループ、messages= 該当グループの保有しているメッセージ一覧に対してwhereを使う
        end
            # ？=後続のパラメータが代入されている→ ? = :id
            # index.json.jbuilderファイルを読み込む
            # jbuilderファイルによって返されるjsonデータはindex.jsファイルに渡される
    end

    private
    def set_group
        @group = Group.find(params[:group_id])
        # groupコントローラの時と異なりfind(params[:group_id])でgroup番号を取得
    end
end