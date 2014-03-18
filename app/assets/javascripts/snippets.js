$(document).on("ready page:load", function(){

// Sign up form validation

  $("#new-snippet form").validate({
    rules: {
      "snippet[title]": {
        required: true,
        maxlength: 200
      },
      "snippet[description]": {
        required: true,
        minlength: 100,
        maxlength: 300
      },
      "snippet[smelly_body]": {
        required: true,
        maxlength: 500
      }
    },
    messages: {
      "snippet[title]": {
        required: "Can't be blank",
        maxlength: "Please, choose something shorter"
      },
      "snippet[description]": {
        required: "Can't be blank",
        maxlength: "No need to be so specific. This description is too long",
        minlength: "Please provide a more detailed description"
      },
      "snippet[smelly_body]": {
        required: "Can't be blank",
        maxlength: "Snippet can't be longer than 500 characters"
      }
    },
    highlight: function(element) {
      $(element).parent('div').removeClass('has-success').addClass('has-error');
    },
    unhighlight: function(element) {
      $(element).parent('div').removeClass('has-error').addClass('has-success');
    }

    })

});
