var RegistrationsController = Paloma.controller('Users/Registrations');

RegistrationsController.prototype.edit = function(){

  $("#minimize").on("switchChange.bootstrapSwitch", function(event,  state){
    var preference = 'minimize';
    var value = state;
    set_user_preference(preference, value, function(){
      $('.smelly-code .clickable').trigger("click")
    })
  });

  $("#line_numbers").on("switchChange.bootstrapSwitch", function(event, state){
    var preference = 'line_numbers';
    var value = state;
    var smelly_code = $("#hidden_smelly_body").val();
    var lexer = "ruby";
    set_user_preference(preference, value, function(){
      highlight_smelly_code(smelly_code, lexer);
    })
  });

  $("#theme").on("change", function(){
    var preference = 'theme';
    var value = $(this).children("option:selected").text();
    var smelly_code = $("#hidden_smelly_body").val();
    var lexer = "ruby";
    set_user_preference(preference, value, function(){
      highlight_smelly_code(smelly_code, lexer);
    })
  });

};

function set_user_preference(preference, value, callback){

  $.ajax({
    type: 'PUT',
    url: '/preferences/update',
    data:{ preference: preference, value: value }
  }).success(function(){
    callback();
  })

}