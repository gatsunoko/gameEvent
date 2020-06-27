//= require nested_fields

//ファイルフィールドに画像をアップしたらプレビューする
function previewFile(name) {
  var preview = document.querySelector('img[name="' + name + '"]');//どこでプレビューするか指定。'img[name="preview"]'などにすればimg複数あっても指定できます。
  var file    = document.querySelector("#previw").files[0];//'input[type=file]'で投稿されたファイル要素の0番目を参照します。input[type=file]にmutipleがなくてもこのコードになります。
  var reader  = new FileReader();

  reader.addEventListener("load", function () {
    preview.src = reader.result;
  }, false);

  if (file) {
    reader.readAsDataURL(file);//ここでreaderのメソッドに引数としてfileを入れます。ここで、readerのaddEventListenerが発火します。
  } else {
    $('img[name="' + name + '"]')[0].src = ""//何も選択されなかったらプレビュー空白にする
    $('img[name="' + name + '"]')[0].alt = ""//何も選択されなかったらプレビュー空白にする
  }
}

//ナビバーを下にスクロールしたら消えて少しでも上にスクロールしたらだす
$(window).on('load', function(){
  var menuHeight = 56;
  var startPos = 0;
  $(window).scroll(function(){
    var currentPos = $(this).scrollTop();
    if (currentPos > startPos) {
      if($(window).scrollTop() >= 200) {
        $("#navbar").css("top", "-" + menuHeight + "px");
      }
    } else {
      $("#navbar").css("top", 0 + "px");
    }
    startPos = currentPos;
  });
});
