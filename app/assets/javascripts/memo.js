// // $(function() {〇〇} = 〇〇に処理を記述することでbodyタグの中身を読み込んだ後に処理を実行する
// $(function() {
//     //$マークの後に引数で指定した要素を取得できる
//     console.log($("#title"));   //# = idセレクタの指定(id属性は被ることがない)
//     console.log($(".sub-title"))    //. = クラスセレクタの指定
//     console.log($("h1"))    //そのまんまタグ名を指定できる(ファイル内のタグを一括取得)

//     // text()= 取得したHTML要素のテキストを書き換える。引数に変更したい文字列
//     $("#title").text("変更したタイトル");
//     $(".sub-title").text("サブサブ！");
//     // html()= 取得したHTML要素のテキストをHTMLのタグを含むテキストに書き換えができる。変更したい内容は引数に文字列で指定
//     // 取得したタグはそのままなので下記の記述はpタグの中にstrongタグとして書き換えられる
//     $("p").html("<strong>変更されたコンテンツ</strong>");

//     var word = $("#title").text();  //text()で取得した要素のテキストを取得
//     $(".sub-title").text(word);     //titleとsub-titleのテキストが入れ替わる

//   });

//   //イベント検知の書き方
//   $(function() {

//     $("セレクタ").on("イベント", function() {
//       イベントが起きた時に行う処理
//     });
//   });

/*第一引数　イベントの種類
  click     =   クリックされた時
  dblclick  =   ダブルクリックされた時
  mouseover =   マウスが要素の上に乗った時
  mouseout  =   マウスが要素から離れた時
  keydown   =   キーが押された時(押した際のキーは判別できない)
  keyup     =   キーが離された時
  change    =   入力内容が変更された時(テキストボックスからフォーカスが外れないとイベント発火しない)

  第二引数にはfunction メソッド名() {イベント処理内容}を記述
  1度きりの使用を想定したメソッドであれば、無名関数を定義。←メソッド名の表記を省略できる

  例：id=titleの要素をダブルクリックでアラートを生成
  $(function() {
    $("#title").on("dblclick", function(){     //on()= クリックされた時に処理を実行
        alert("タイトルがクリックされました");
    });
  });
*/
    // //設置されたフォームの文字数をカウント
    // $(function() {
    //     $("#input-text").on("keyup", function(){
    //         var charNum = String($(this).val().length);
    //         //$(this)でinput-textのテキスト
    //         //val()でフォームの値を取得
    //         //String型にキャスト
    //         $("#char-count").text(charNum + "文字");        //char-countブロックのテキストを変更
    //     });
    // });

/*  メソッドの種類
    on()    = JQueryオブジェクトに対してイベントを設定するメソッド(イベントと行う処理を記述する)
    hide()  = 要素を非表示にすることができる
    show()  = 非表示の要素を表示にできる。さらにJQueryでは表示・非表示にアニメーションを加えられる
*/

    // //要素の非表示と表示させる
    // $(function() {
    //     //hideボタンを押した時
    //     $("#hideButton").on("click", function() {
    //         $("#title").hide();
    //     });

    //     //showボタンを押した時
    //     $("#showButton").on("click", function() {
    //         $("#title").show();
    //     });

    //     //fade outボタンを押した時
    //     $("#fadeOutButton").on("click", function() {
    //         $("#title").fadeOut(1000);      //引数にはフェードアウトしていく時間を指定
    //     });

    //     //fade inボタンを押した時
    //     $("#fadeInButton").on("click", function() {
    //         $("#title").fadeIn(3000);
    //     });

    //     //appendボタンを押した時
    //     $("#appendButton").on("click", function() {
    //         $("#title").append('<li class="list">追加されたリスト</li>');
    //         //append()= セレクタのタグに引数で記述したHTMLを追加できる
    //         //html()= 上書き、append()= 追加
    //     });

    //     //removeボタンを押した時
    //     $("#removeButton").on("click", function() {
    //         $(".list").remove();
    //         //remove()= 指定したHTML要素を削除できる
    //         //empty()= 指定した要素の子要素全てを削除する
    //     });

    //     //add classボタンを押した時
    //     $("#addClassButton").on("click", function() {
    //         $("#title").addClass("red");     //pタグにstyle.cssファイルにてあらかじめ用意しているredクラスを追加する
    //     });

    //     //remove classボタンを押した時
    //     $("#removeClassButton").on("click", function() {
    //         $("#title").removeClass("red");      //セレクタの要素から引数で指定したクラスを削除
    //     });
    //     //toggleClass()= セレクタの要素から引数で指定したクラスがすでに存在する場合はremove、ない場合はaddを行う便利なメソッド

    //     //マウスが要素の上に乗せたら文字色を変える
    //     $("#title").on("mouseover mouseout", function() {
    //         $(this).toggleClass("red");     //thisは対象のセレクタ自身= イベントを起こしたインスタンスのこと
    //     });

    //     //get attrボタンを押した時
    //     $("#getAttrButton").on("click", function() {
    //         console.log($("img").attr("src"));
    //         //引数が1つの場合は属性値を取得
    //     });

    //     //change attrボタンを押した時
    //     $("changeAttrButton").on("click", function() {
    //         $("img").attr("src", "http://yoso-walk.net/wp-content/uploads/2014/07/enhanced-buzz-wide-6868-1401738537-9_R.jpg");
    //     });
    //     //attr()= 第一引数にセレクタの属性、第二引数に置き換えたい値を記述

    //     //valボタンを押した時
    //     $("#valButton").on("click", function() {
    //         console.log($("input").val());
    //     });
    // });
