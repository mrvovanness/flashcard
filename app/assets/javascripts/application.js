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

$(document).ready(function() {
  $("#new_deck_target, #cancel_new_deck").click(function() {
    $(".card_deck").toggle();
  });

  $(document).on("click", "#check-button", function(event) {
    event.preventDefault();
    var paramsArray = $("#check_form").serializeArray();
    var data = {};
    for (i = 0; i < paramsArray.length; i++) {
      data[paramsArray[i].name] = paramsArray[i].value;
    }
    $.post("/check", data, function(responseText) {
      $("#flash_wrapper").html(responseText.alert); 
      $("#check_form").load("/index" + " #check_form *");
    }, "json");
  });

  setTimeout(function() { hideAlert() }, 4500);
  function hideAlert() {
    $(" #flash_wrapper *").fadeOut("slow", function() {
      $(this).remove();
    });
  }

  setInterval(function() { myTimer() }, 1000);
  var seconds = 0;
  function myTimer() {
    $("#timer").val(seconds);
    seconds ++;
  }

  $(document).on("ajaxComplete", function() {
    seconds = 0;
    setTimeout(function() { hideAlert() }, 5000);
  });
});
