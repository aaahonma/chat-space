require 'rails_helper'

describe MessagesController do
    # letは複数のexampleブロックで同一のインスタンスを使用する場合に使用
    # let=メソッドが呼び出されて初めて実行される遅延評価式のメソッド
  let(:group) { create(:group) }
  let(:user) { create(:user) }

  describe '#index' do

    context 'log in' do
      before do  # exampleブロック実行前に毎回行われる処理　毎回がミソ！
        login user  # controller_macros.rbに記述したメソッド
        get :index, params: { group_id: group.id }
        # 擬似的にindexアクションを動かすリクエスト実行
        # messagesのルーティングがgroupsにネストされているため、アクションの引数でgroup_idを渡す必要あり
      end

      # アクション内で定義しているインスタンス変数があるか
      it 'assigns @message' do
        expect(assigns(:message)).to be_a_new(Message)
        # :message = @message
        # be_a_newマッチャ=引数で指定したクラスの、インスタンスかつ未保存のレコードかどうか
      end

      it 'assigns @group' do
        expect(assigns(:group)).to eq group
        # eqマッチャ=expect内のモデルと同一かどうか(つまりassigns(:group)と同一かどうか)
      end

      # indexアクションに該当するビューがあるかどうか
      it 'redners index' do
        expect(response).to render_template :index
        # response=リクエストが実行された後の遷移先ビューの情報インスタンス
        # render_templateマッチャ=引数で指定したアクションのビューを返す
        # render_templateとresponseを合わせて使うと返されたビューの結果を比較できる
      end
    end

    context 'not log in' do
      before do
        get :index, params: { group_id: group.id }
      end

      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
        # edirect_toマッチャ=引数のPrefixにリダイレクトした際の情報を返すマッチャ(beforeの処理環境でredirectした時の反応・情報)
      end
    end
  end

  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }
    # createアクションのリクエストで必要になるparamsを生成(定義)
    # attributes_for=createやbuild同様FactoryBotで定義されているメソッド、オブジェクトを生成背zにハッシュを生成できる

    # ログイン状態で
    context 'log in' do
      before do  # exampleブロック実行前に毎回行われる処理　毎回がミソ！
        login user  # controller_macros.rbに記述したメソッド
      end

      # かつ投稿データの保存に成功している状態
      context 'can save' do
        subject {           # メソッドのような扱いcontextブロック内で複数回使う場合は定義
          post :create,     # postメソッドでcreateアクションを擬似的にリクエスト
          params: params    # letで定義したparamsを渡す
        }

        # メッセージの保存はできたかどうか
        it 'count up message' do
          expect{ subject }.to change(Message, :count).by(1)
        # changeマッチャ=引数が変化したかどうか確かめる
        # :count=Messageモデルのレコードの総数が.by(n)個の変化(今回の記述では)1つ増えたかどうか(保存が成功するとレコードが1つ増えるため)
        end

        # 意図した画面に遷移しているか
        it 'redirects to group_messages_path' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      # かつ投稿データの保存に失敗している状態
      context 'can not save' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }
        # invalid_paramsを定義
        # 生成するmessageの属性がcontentもimageもnilで作成

        subject {
          post :create,
          params: invalid_params
        }

        # メッセージの保存はできなかったかどうか
        it 'does not count up' do
          expect{ subject }.not_to change(Message, :count)
          # expect{〜}.to 〇〇　＝　〇〇であること
          # expect{〜}.not_to 〇〇　＝　〇〇でないこと
          # Messageモデルのレコード数が変化しないこと
        end

        # 意図した画面に遷移しているか
        it 'renders index' do
          subject
          expect(response).to render_template :index
          # メッセージの保存に失敗したらindexビューに遷移する設定
        end
      end
    end

    # ログインしていない状態
    context 'not log in' do

      # 意図した画面に遷移しているか
      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end