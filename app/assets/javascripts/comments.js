// 

document.addEventListener("turbolinks:load", function() {
  $(document).ready(function() {
    $(document).on('click', '#comment_edit_cancel', function () {
      $('#for_this_comment').remove();
      console.log("AAAAAAAAAAAA")
    })
  });
})


