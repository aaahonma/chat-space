class Api::MessagesController < ApplicationController
    # ::= 名前空間 or namespaceという。クラス名を繋げることで装飾が可能
    # apiフォルダのMessagesControllerとして区別できる
    def index
        @update_messages = Message.where('id LIKE(?)', "%#{params[:id]}%")
        # ？=後続のパラメータが代入されているLIKE(/*id*/)
        respond_to do |users|
            users.html
            users.json
            # index.json.jbuilderファイルを読み込む
            # jbuilderファイルによって返されるjsonデータはindex.jsファイルに渡される

    end
  end