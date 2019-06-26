$(function () {

    var result_list = $("#user-search-result")
    var member_list = $("#add-member")

    //検索該当ユーザーの候補HTMLの追加メソッド
    function appendUserHTML(user) {
        var html_head    = `<div class="chat-group-user clearfix">`;
        var html_content = ``;
        var html_foot    = `</div>`;
        if (user instanceof Object) {
            html_content = `<p class="chat-group-user__name">${ user.nickname }</p>
                            <div class="user-search-add chat-group-user__btn chat-group-user__btn--add" data-user-id="${ user.id }" data-user-nickname="${ user.nickname }">追加</div>`;
        }else{
            html_content = `<p class="chat-group-user__name">${ user }</p>`;
        }
        result_list.append(html_head + html_content + html_foot);
    }

    //候補ユーザーをメンバーHTMLへの追加メソッド
    function addUserToMember(id, nickname) {
        var html = `<div class='chat-group-user clearfix js-chat-member' id="'chat-group-user-' ${ id }">
                        <input name='group[user_ids][]' type='hidden' value='${ id }'>
                        <p class='chat-group-user__name'>${ nickname }</p>
                        <div class='user-search-remove chat-group-user__btn chat-group-user__btn--remove js-remove-btn'>削除</div>
                    </div>`;
        member_list.append(html);
    }



    //検索フォームのキーアップを検知して入力情報を送信
    $("#user-search-field").on("keyup", function() {
        var input = $(this).val();

        $.ajax({
            type: 'GET',
            url: '/users',              //users#indexアクションへ情報を送る
            data: { nickname: input },  //users#indexアクションで[:nickname]というキー名でinputバリューを扱うことができる
            dataType: 'json'            //users#indexアクションから返してもらうデータの型を指定
        })

        .done(function(users) {         //users= users#indexアクションから返されたユーザーの配列jsonデータ
            $("#user-search-result").empty();
            // 検索に引っかかるユーザー情報を表示するブロックの子要素を削除する
            // empty()= DOM要素の子要素を削除する
            if (users.length !== 0) {   //検索にヒットした情報が1件以上だったら
                users.forEach(function(user) {
                    appendUserHTML(user);
                });
            }
            else {
                appendUserHTML("一致するユーザーが見つかりません");
            }
        })
        .fail(function() {
            alert('ユーザー検索に失敗しました');
        })
    });

    //追加ボタンの検知
    $("#user-search-result").on("click", ".chat-group-user__btn--add", function() {
        var user_id = $(this).data("user-id");
        var nickname = $(this).data("user-nickname");
        $(this).parent().remove();
        addUserToMember(user_id, nickname);
    });

    //メンバーブロックの削除ボタンの検知
    $("#add-member").on("click", ".js-remove-btn", function() {
        $(this).parent().remove();
    });
});
