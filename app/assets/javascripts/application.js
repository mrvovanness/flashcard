// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require bootstrap

$( document ).ready(function() {
  $("#new_deck_target, #cancel_new_deck").click(function() {
    $(".card_deck").toggle();
  });

  setTimeout(function() {
    $("#flash-wrapper").fadeOut("slow", function() {
      $(this).remove();
    });
  }, 4500 );

  i = setInterval(function() {myTimer()}, 1000);
  var seconds = 0;
  function myTimer() {
    $("#timer").val(seconds);
    seconds ++;
    console.log(seconds);
  };

  $(document).on('ajax:complete', function(event) {
    clearInterval(i);
    seconds = 0
    i = setInterval(function() {myTimer()}, 1000);
    console.log(i);
  });
});
