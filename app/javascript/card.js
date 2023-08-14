//// クレジットカード情報を取得し、PAY.JPのトークンを生成してフォームに追加し、フォームを送信する関数
const pay = () => {
  // PAY.JPライブラリの初期化
  const publicKey = gon.public_key
  const payjp = Payjp(publicKey) // PAY.JPテスト公開鍵// PAY.JPテスト公開鍵
  // クレジットカード情報入力欄を生成
  const elements = payjp.elements();
  const numberElement = elements.create('cardNumber');//カード番号入力欄
  const expiryElement = elements.create('cardExpiry');//有効期限入力欄
  const cvcElement = elements.create('cardCvc');//CVC入力欄

  // 各入力欄を対応する要素にマウント
  numberElement.mount('#number-form');//引数で要素のid属性を指定し、指定した要素とelementインスタンスが情報を持つフォームとを置き換えるメソッドです。
  expiryElement.mount('#expiry-form');
  cvcElement.mount('#cvc-form');
  // フォーム送信時のイベントリスナー
  const form = document.getElementById('charge-form')
  form.addEventListener("submit", (e) => {
    payjp.createToken(numberElement).then(function (response) {
      if (response.error) {
       // エラーがあれば処理
      } else {
        const token = response.id;//1. トークンの情報をフォームに追加する
        const renderDom = document.getElementById("charge-form");//2. クレジットカードの情報をフォームから取り除く
        const tokenObj = `<input value=${token} name='token' type="hidden">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);//insertAdjacentHTMLメソッド(JavaScriptのDOM操作用メソッド)で、フォームの中に作成したinput要素を追加しています。
      }
      // 入力欄をクリア
      numberElement.clear();
      expiryElement.clear();
      cvcElement.clear();
      // フォームを送信
      document.getElementById("charge-form").submit();
  });
    // 通常のフォーム送信をキャンセル
    e.preventDefault();
  });
};
// 「ページが読み込まれたら」('turbo:load', 【実際に行う処理】)
window.addEventListener('turbo:load', pay);