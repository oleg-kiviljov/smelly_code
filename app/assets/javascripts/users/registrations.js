function set_user_preference(preference, value){

  $.ajax({
    type: 'PUT',
    url: '/settings/update',
    data:{ preference: preference, value: value }
  }).success(function(){

      })

}