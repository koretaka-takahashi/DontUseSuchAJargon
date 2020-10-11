// 検索機能のモーダル開閉（Not Bootstrap）
document.addEventListener("turbolinks:load"
, function(){
  $(function(){
    $('.js-modal-open-search').on('click',function(){
        $('.js-modal-search').fadeIn();
        return false;
    });
    $('.js-modal-close-search').on('click',function(){
        $('.js-modal-search').fadeOut();
        return false;
    });
  });
})

// 投稿のモーダルでエラー表示後に閉じたら、次開けた時にエラーが残らないように消しておく
document.addEventListener("turbolinks:load", function() {
  $(document).ready(function() {
    $('#termModal').on('hidden.bs.modal', function () {
      $('#error_explanation').remove();
    })
  });
})


// 投稿のモーダルで２度目以降のエラーが表示されないのを解消するため、エラー部分を再度持ってくる
// （// $('#error_explanation')の後の.remove()は存在意義が不明なので消した）
document.addEventListener("turbolinks:load", function() {
  $(document).ready(function() {
    const e = $('#error_explanation')
  
    $('#modal_error_resurrection').on('click', function () {
      $('#term-error-area').append(e);
    });
  });
})


