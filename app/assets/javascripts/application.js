// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
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
//= require bootstrap
//= require sliding-panel/sliding-panel
//= require jquery-validation/jquery.validate.min
//= require jquery-timeago/jquery.timeago
//= require chosen-jquery
//= require bootstrap-switch/bootstrap-switch
//= require messenger
//= require highlight/highlight.pack
//= require_tree .
//= require_self

$(document).on("ready page:load", function(){
  autohide_alerts();
  initialize_chosen();
  initialize_bootstrap_switch();
  initialize_messenger();
  initialize_highlight();
});

function show_message(message, type){
  Messenger().post({
    message: message,
    type: type
  })
}

function fetch_resource_id(){
  return window.location.href.split('/')[4]
}

function scroll_to_element(selector, time, verticalOffset) {
  time = typeof(time) != 'undefined' ? time : 1000;
  verticalOffset = typeof(verticalOffset) != 'undefined' ? verticalOffset : 0;
  var element = $(selector);
  var offset = element.offset();
  var offsetTop = offset.top + verticalOffset;
  $('html, body').animate({
    scrollTop: offsetTop
  }, time);
}


function delay(ms) {
  var timer = 0;
  return function(callback){
    clearTimeout (timer);
    timer = setTimeout(callback, ms);
  }
}

function initialize_highlight(){
}

function initialize_messenger(){
  Messenger({
    theme: 'flat'
  });
}

function initialize_timeago(){
  $('.time-ago').timeago();
}

function initialize_chosen(){
  $('.chosen-select').chosen({
    no_results_text: "Can't find anything like",
    width: '100%',
    disable_search_threshold: 10,
    allow_single_deselect: true
  })
}

function initialize_bootstrap_switch(){
  $('.switch').bootstrapSwitch();
}

function autohide_alerts() {
  setTimeout(function(){
    $(".alert").slideUp(300)
  }, 5000);
}



