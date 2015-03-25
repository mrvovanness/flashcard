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
//= require turbolinks
//= require_tree .
//= require bootstrap

jQuery(document).on("ready page:change", function() { documentReady()
})

function documentReady() {
  $("#new_deck_target").click(function() {
    $("#new_deck_name").removeClass("hidden");
    $(".card_deck").hide();
    $("#new_deck_target").hide();
    $("#new_deck_target").after("<a>Oтменить</a>");
    $("#new_deck_target + a").click(function() {
      $("#new_deck_name").addClass("hidden");
      $("#new_deck_target + a").hide();
      $(".card_deck").show();
      $("#new_deck_target").show();
    });
  });
}

