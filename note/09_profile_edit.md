# 09 プロフィール編集機能の実装
## JSのイベント登録について
JSでのイベント操作は、複数の方法がある。

### ①イベントハンドラーを使用(要素オブジェクトのプロパティとして設定)
```html
<!-- html -->
 <input id="btn" type="button" value="テスト用">
```
```js
// 対象オブジェクトのonclockプロパティに処理する内容を渡す。
document.getElementById('btn').onclick = btn_alert;
// 実施したいイベントを記載。
const btn_alert = function(){
    window.alert("ボタンがクリックされた。");
}
```

### ②イベントハンドラーを使用(タグ内の属性として設定)
```html
<!-- htmlの属性のようにjsを記載する(jsの関数オブジェクトを渡してもOK) -->
 <input id="btn" type="button" value="テスト用" onclick="window.alert("ボタンがクリックされた。");">
```

### ③イベントリスナーを使用
```html
 <input id="btn" type="button" value="テスト用">
```
```js
// ベントリスナーの処理に処理する内容を渡す。(第3引数をtrueにすると一度実行されたハンドラが自動的に削除する。)
document.getElementById('btn').addEventListner('click', btn_click, false);
// 実施したいイベントを記載。
const btn_alert = function(){
    window.alert("ボタンがクリックされた。");
}
```

### ④jQueryを使用(onメソッドを使用しない)
```html
<input type="button" class="sample" value="イベント">
```
```js
$('.sample').click(function(){
    alert('ボタンがクリックされた。');
});
```

### ⑤jQueryを使用(onメソッドを使用する)
```html
<input type="button" class="sample" value="イベント">
```
```js
// onメソッドの場合は、一度に複数のイベントタイプを定義できたり、データを渡すことができる。
$('.sample').on('click', function(){
    alert('ボタンがクリックされた。');
});
```

### 参考サイト
[Quita](https://qiita.com/hththt/items/aefbcc6eb191588dadff)  
[JSのデバック方法](https://qiita.com/ozackiee/items/928d28dd079e85b4c525)  
[.on()と.off()を使いこなす](https://www.codegrid.net/articles/2014-practical-jquery-1/)


## イベントオブジェクトについて
イベントハンドラーおよびイベントリスナーにおいて実行される関数の引数として受け取ることのできるオブジェクト。  
発生したイベントに関わる様々な情報（プロパティ）を知ることできる。  
※以下色々間違えている可能性あり。

### 方法①(属性形式のイベントハンドラー使用時)
```html
<!-- eventを引数として渡す必要がある(また他の部分のセレクタも渡すこともできる) -->
<input type="button" name="B1" onclick="func(event)" value="OK">
```
```js
// 引数の変数名は自由
function func(event){
    console.log('Hello');
}
```

### 方法②(属性形式でないイベントリスナー使用時)
```html
<input type="button" value="button" id="xxx">
```
```js
// イベントリスナーの場合は、第一引数(名前は自由)が勝手にイベントオブジェクトになる。
function butotnClick(event){
    console.log('Hello');
}

let button = document.getElementById('xxx');
button.addEventListener('click', butotnClick);
```

### 参考サイト
[MDN①](https://developer.mozilla.org/ja/docs/Learn/JavaScript/Building_blocks/Events#event_objects)  
[MDN②](https://developer.mozilla.org/ja/docs/Archive/Mozilla/XUL/Tutorial/More_Event_Handlers)  
[Event.currentTargetとEvent.targetの違いについて
](https://www.javadrive.jp/javascript/event/index9.html)
