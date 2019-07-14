class MessagesController < ApplicationController
  before_action :set_group # 全てのアクション内で@group変数を使えるようにする

  def index
    @message = Message.new  # form_forで新規投稿フォームを作成するために必要
    @messages = @group.messages.includes(:user)
    # @messageは入力フォームやメッセージ一覧部分に渡す引数
    # @messagesはグループに所属する全てのメッセージ
    # includes(:user)なぜuser?
  end

  def create
    @message = @group.messages.new(message_params)  # newメソッド?で該当groupのmessages配列に新規メッセージ追加→newアクションが定義されていないため、合わせて下段のsaveが実行できるか確認するためにnewアクションにとどめている
    if @message.save
      respond_to do |format|
        format.html { redirect_to group_messages_path(@group), notice: 'メッセージが送信されました' }
        format.json
      end
    else
      # create失敗、再度投稿
      @messages = @group.messages.includes(:user)  # 新規メッセージを追加したい大元の既存メッセージ群を取得
      flash.now[:alert] = 'メッセージを入力してください' # flash.now= 現在のリクエスト画面にのみ表示可能なメッセージ
      render :index
    end
  end

  private
  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
    # requireの引数はシンボル型で宣言
    # 「:カラム名」paramsのカラム指定、「カラム名:」指定カラムに代入
  end

  def set_group
    @group = Group.find(params[:group_id])
    # groupコントローラの時と異なりfind(params[:group_id])でgroup番号を取得
  end
end
