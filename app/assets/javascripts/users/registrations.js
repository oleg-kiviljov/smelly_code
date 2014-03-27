function set_user_preference(preference, value, callback){

  $.ajax({
    type: 'PUT',
    url: '/preferences/update',
    data:{ preference: preference, value: value }
  }).success(function(){
    callback();
  })

}