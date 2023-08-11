function commission () {
// constは、後から書き換えることができない変数を定義する書き方です。
// idが付与されているため、getElementByIdを用いて取得します。
  const price = document.getElementById('item-price');
  const tax_price = document.getElementById('add-tax-price');
  const profit = document.getElementById('profit');
  
  price.addEventListener('change', function() {
// letは、後で書き換えることができる変数を定義する書き方です。
    let taxValue = Math.floor(price.value*0.1);//手数料
    let profitValue = price.value - taxValue//利益計算

    tax_price.textContent = '';
    profit.textContent = '';
    
// ブラウザのコンソールにテキストを表示させるメソッドです
    tax_price.insertAdjacentHTML("afterbegin",taxValue)
    profit.insertAdjacentHTML("afterbegin",profitValue)
  })
};
// 「ページが読み込まれたら」('turbo:load', 【実際に行う処理】)
window.addEventListener('turbo:load', commission);