// ファイル名はコントローラ名.js
// フォームの送信がされたときのイベント
$(function() {

    //⑤構築したHTMLをViewに差し込む
    //buildHTML関数を定義
    function buildHTML(message) {

        var img = ""
        //画像が投稿されなかった際を考慮する
        if (message.image !== null) {
            img = `<img class="lower-message__image" src="${ message.image }">`
        }
        var html = `<div class="message">
                        <div class="upper-message">
                            <div class="upper-message__user-name">
                            ${ message.user_name }
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

        var textField = $("#message_content");       //入力フォーム
        var imageField = $("#message_image");        //画像格納ブロック

        //①-2, Ajaxをするために必要な情報の準備をする
        $.ajax({
            url: url,           //リクエストを送信する先のurl(/groups/1/messages)
            type: 'POST',       //HTTP通信の種類を記述
            data: formData,
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
            textField.val('');      //入力テキストをリセット
            imageField.val('');     //画像フォルダをリセット

        })
        //失敗したとき
        .fail(function() {
            alert('error');
        });

        //SENDボタンの連打防止(3秒後にdisabled解除)
        var self = this;
        $(".form__submit", self).prop("disabled", true);
        setTimeout(function() {
        $(".form__submit", self).prop("disabled", false);
        }, 3000);


        //ページ最下部へスクロールする
        var speed = 500;
        var element = document.getElementById( "messages" );    //各メッセージの親要素「messages」のnodeを取得
        var lastElement = element.lastElementChild;             //lastElementChild= 子要素の最後の要素を取得
        var position = $(lastElement).offset().top;
        $(".messages").animate({scrollTop:position}, speed, 'swing');
    });
});