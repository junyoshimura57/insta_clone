// 解答ではjQueryのReady関数を使用して、JS発火のタイミングを調整してたが、練習としてaddEventListenerで書き換え。
document.addEventListener('DOMContentLoaded', function () {
  new Swiper('.swiper-container', {
    pagination: {
      el: '.swiper-pagination',
    },
  })
})