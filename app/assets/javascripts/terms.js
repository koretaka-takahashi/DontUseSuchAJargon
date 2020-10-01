// モーダルでエラー表示後に閉じたら、次開けた時にエラーが残らないように決しておく
$(document).ready(function() {
  $('#termModal').on('hidden.bs.modal', function () {
    $('#error_explanation').remove();
  })
});

// モーダルで２度目以降のエラーが表示されないのを解消するため、エラー部分を再度持ってくる
// （// $('#error_explanation')の後の.remove()は消した）
$(document).ready(function() {
  const e = $('#error_explanation')

  $('#modal_error_resurrection').on('click', function () {
    $('#term-error-area').append(e);
  });
});

