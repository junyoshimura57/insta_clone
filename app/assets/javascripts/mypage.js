//= require jquery3
//= require popper
//= require rails-ujs
//= require bootstrap-material-design/dist/js/bootstrap-material-design.js

// このjsでプレビュー表示処理を行っている。(難しい...)
// イベントハンドラーの引数にはselector=previewを渡す。
function previewFileWithId(selector) {
    // イベントを発生させたオブジェクト(file_fieldで生成されたinput要素)を呼び出す。
    //　thisはwindowオブジェクトを指す。(html要素の属性に指定している際にはwindowっぽい...)
    const target = this.event.target;
    // オブジェクトの配列で保存されているfilesプロパティを取得。
    const file = target.files[0];
    // FileReaderオブジェクトを作成する。
    const reader = new FileReader();
    // 読み込み操作が完了するたびに発火されるイベントを設定
    reader.onloadend = function () {
        // ファイルデータの文字列をimgタグのsrc属性にいれる。
        selector.src = reader.result
    }
    // 画像が選択されている場合は、ファイルの内容を読み込みonloadイベントを発火させる。
    if (file) {
        reader.readAsDataURL(file);
    } else {
        selector.src = "";
    }


}
