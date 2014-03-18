$(document).on("ready page:load", function(){

// Sign up form validation

$("#sign-up form").validate({
  rules: {
    "user[username]": {
      required: true,
      maxlength: 20,
      minlength: 4,
      remote: {
        type: 'POST',
        url: "/credentials_already_taken"
      }
},
"user[email]": {
    required: true,
    email: true,
    remote: {
    type: 'POST',
    url: "/credentials_already_taken"
    }
},
"user[password]": {
    required: true,
    minlength: 8
    },
"user[password_confirmation]": {
    required: true,
    equalTo: '#user-password'
    }
},
messages: {
    "user[username]": {
    required: "Can't be blank",
    maxlength: "Is too long (maximum is 20 characters)",
    minlength: "Is too short (minimum is 4 characters)",
    remote: 'Username is already taken'
    }
,
"user[password]": {
    required: "Can't be blank",
    minlength: "Is too short (minimum is 8 characters)"
    },
"user[password_confirmation]": {
    required: "Can't be blank",
    equalTo: "Passwords don't match"
    },
"user[email]": {
    required: "Can't be blank",
    email: "Invalid email",
    remote: 'Email is already taken'
}
}, highlight: function(element) {
    $(element).parent('div').removeClass('has-success').addClass('has-error');
  },
  unhighlight: function(element) {
    $(element).parent('div').removeClass('has-error').addClass('has-success');
  }


})

});
