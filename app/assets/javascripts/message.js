// ファイル名はコントローラ名.js
$(function() {
    //htmlタグ配下の要素を全部読み込む

    //⑤構築したHTMLをViewに差し込む
    //buildHTML関数を定義
    function buildHTML(message) {

        //三項演算子の応用(変数 = 条件式 ? true : false)
        var img = (message.image !== null) ? `<img class="lower-message__image" src="${ message.image }">` : "" ;

        var html = `<div class="message" data-id="${ message.id }" data-group-id="${ message.group_id }" data-created_at="${ message.created_at }">
                        <div class="upper-message">
                            <div class="upper-message__user-name">
                            ${ message.user_nickname }
                            </div>
                            <div class="upper-message__data">
                            ${ message.created_at }
                            </div>
                        </div>
                        <div class="lower-message">
                            <p class="lower-message__content">
                            ${ message.content }
                            </p>
                            ${ img }
                        </div>
                    </div>`
        return html;
    }

    //SENDボタンの連打防止(3秒後にdisabled解除)
    //prop()= 要素のプロパティを取得する
    var self = this;
    $(".form__submit", self).prop("disabled", true);
    setTimeout(function() {
    $(".form__submit", self).prop("disabled", false);
    }, 3000);

    //ページ最下部へスクロールする
    function scroll_view() {
    $(".messages").animate({ scrollTop:$(".messages")[0].scrollHeight }, 500, 'swing');
    }


    //①フォームの送信が行われたときにAjaxによる非同期通信を始める(ためのイベントハンドラ)
    $("#new_message").on("submit", function(e) {
        e.preventDefault();

        // debugger
        //①-1, フォームに入力された値を取得
        var formData = new FormData(this);
        // FormData= フォームのデータの送信に使用可能
        //引数がthisのため、id=new_messageのフォームタグのフォーム情報
        var url = $(this).attr('action')
        //attr= 要素が持つ指定属性の値を返す　　実際の返り値= action="/groups/1/messages"
        //指定した属性がなければundefinedが返ってくる

        //①-2, Ajaxをするために必要な情報の準備をする
        $.ajax({
            url: url,           //リクエストを送信する先のurl(/groups/1/messages)
            type: 'POST',       //HTTP通信の種類を記述
            data: formData,
            timeout : 30000,                //サーバーからの返信が30秒経ってもないときはタイムアウト設定
            dataType: 'json',
            processData: false,
            // デフォルトはtrue、dataに指定したオブジェクトをクエリ文字列に変換する役割
            // クエリ文字列= WebブラウザなどがWebサーバに送信するデータをURLの末尾に特定の形式で表記したもの
            contentType: false
            //デフォルトはtext/xml、サーバーへデータのファイル形式を伝えるヘッダ。コンテンツタイプをXMLとして返してくる設定
            //今回はdataがformDataで適切な値のため、falseにすることで設定の上書きを防いでいる。
        })
        //上記通信内容：通信方法＝POST, /groups/1/messagesというURLに,テキストフィールドに入力された値を送信する,サーバーから送信を返す際はjson形式とする
        //②messagesコントローラのcreateアクションでmessageの保存を行う　　※要は、DBにmessageデータを登録する
        //③ ②の処理後にjsonを返す

        //④非同期通信の終了後にコントローラから受け取ったjsonを利用してHTMLを構築する
        //非同期通信に成功した時
        .done(function(message) {
            var html = buildHTML(message);
            $('.messages').append(html);
            $("#new_message")[0].reset();      //入力テキスト,画像データをリセット(送信データ関係をリセットできる)
            scroll_view()
        })
        //失敗したとき
        .fail(function() {
            alert('error');
        });
    });

    function reloadMessages() {

        var last_message = $(".messages .message:last-child")                     //最新のメッセージDOM
        var current_group_id = last_message.data("group-id");                      //現在のグループid
        var messages_index_url = '/groups/' + current_group_id + '/messages';      //messagesコントローラindexアクションのURL

        // messages#indexアクション画面のみreloadMessagesメソッドを実行
        if (messages_index_url == location.pathname ) {

            //カスタムデータ属性を利用して、ブラウザに表示されている最新メッセージのidを取得
            var last_message_id = (typeof $(".messages .message:last-child").get(0) == "undefined" ) ? 0 : last_message.data("id");
            //typeof= データ型を取得する
            //:last-child= セレクタ：の子要素の最後のブロックを取得(セレクタでは親要素と子要素のタグを指定する必要あり)
            //.get(0)= $()で囲んだjQuery型のDOM要素を素のDOM要素に変換する => javascript言語のメソッドが適用可能になる
            //messageブロックが存在しなければ検索idに0を代入=>メッセージが1件もない時の対策

            var ajax_url = '/groups/' + current_group_id + '/api/messages';

            $.ajax({
                url: ajax_url,                        //ルーティングで設定した通りのURLを指定
                type: 'get',                    //ルーティングで設定したhttpメソッド
                dataType: 'json',
                timeout : 30000,                //サーバーからの返信が30秒経ってもないときはタイムアウト設定
                data: {id: last_message_id}     //dataオプションでリクエストに値を含める
            })
            .done(function(messages) {
                if (messages.length > 0 ) {                  //更新されたmessages配列に情報が入っていたら、以下を処理
                    var insertHTML = '';                     //追加するHTMLの変数を用意
                    messages.forEach(function (message) {    //配列messagesの中身を一つ一つ取り出して、HTMLに変換したものを入れ物に足し合わせる
                        insertHTML = buildHTML(message);     //メッセージが入ったHTMLを取得
                        $('.messages').append(insertHTML);   //メッセージを追加
                    });
                    scroll_view();      //最下部までスクロール
                }
            })
            .fail(function() {
                alert("自動更新に失敗しました");
            });
        }
    };

    setInterval(reloadMessages, 5000);          //setInterval= 一定時間の間隔で処理を実行可能(行いたい処理, 時間間隔)
});
