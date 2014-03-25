$(document).on("ready page:load", function(){

// Insert values from form to snippet example
  $("#snippet-form #snippet_title, #snippet_description").on("keyup blur", function(){
    var selector_id = $(this).attr('id').replace('snippet_', '');
    var $selector = $("#"+selector_id);
    insert_text($(this), $selector)
  });

// Insert programming lexer on page load
insert_text($("#snippet_lexer_id"), $("#lexer_id"));

// Insert highlighted code into example snippet
$("#snippet_lexer_id").on("change", function(){
   var smelly_code = $("#snippet_smelly_body").val();
   var lexer = $("#snippet_lexer_id").children("option:selected").text();
   insert_text($("#snippet_lexer_id"), $("#lexer_id"));
   highlight_smelly_code(smelly_code, lexer)
});

$("#snippet_smelly_body").on("blur", function(){
  var smelly_code = $(this).val();
  var lexer = $("#snippet_lexer_id").children("option:selected").text();
  highlight_smelly_code(smelly_code, lexer)
});


// Sign up form validation

  var snippet_form = $("#snippet-form form").validate({
    rules: {
      "snippet[title]": {
        required: true,
        maxlength: 200
      },
      "snippet[description]": {
        required: true,
        minlength: 50,
        maxlength: 300
      },
      "snippet[smelly_body]": {
        required: true,
          remote: {
            type: 'POST',
            url: '/snippets/check_lines_of_code',
            data: {lexer: $("#snippet_lexer_id").children("option:selected").text()}
          }
        }
    },
    messages: {
      "snippet[title]": {
        required: "Title is missing",
        maxlength: "Too long for a title"
      },
      "snippet[description]": {
        required: "Minimum: 50 characters",
        maxlength: "No need to be so specific. This description is too long",
        minlength: "Please provide more detailed description"
      },
      "snippet[smelly_body]": {
        required: "There is no smelly code :(",
        remote: "Only 15 lines of code allowed (empty lines don't count)"
      }
    },
    highlight: function(element) {
      $(element).parent('div').removeClass('has-success').addClass('has-error');
    },
    unhighlight: function(element) {
      $(element).parent('div').removeClass('has-error').addClass('has-success');
      $(element).parent('div').find('.label-danger').remove()
    },
    errorPlacement: function(label, element) {
      $('<span class="label label-danger"></span>').insertAfter(element)
      $(element).next('span.label-danger').append(label)
    }
  });

  $("#create-snippet").click(function(){
    snippet_form.form();
    if(snippet_form.valid()) { $("#snippet-form form").submit() }
  })

});

function highlight_smelly_code(smelly_code, lexer){
  $.ajax({
    type: 'POST',
    url: '/snippets/highlight_code',
    data: { smelly_code: smelly_code, lexer: lexer }
  }).success(function(data){
        $("#smelly_body").empty().html(data.highlighted_code);
      })
}

function insert_text($input, $selector){
  var tag = $input.prop("tagName");
  if(tag == 'SELECT'){
    var value = $input.children("option:selected").text();
  } else {
    var value = $input.val() || $input.text();
  }
  $selector.text(value)
}

function load_result_snippet(){
  var title = $("#snippet_title").val();
  var description = $("#snippet_description").val();
  var raw_smelly_code = $("#snippet_smelly_body").val();
  var lexer = $("#snippet_lexer_id").children("option:selected").text();
  var highlighted_smelly_code = highlight_smelly_code(raw_smelly_code, lexer);

  $("#title").text(title);
  $("#description").text(description);
  $("#smelly_body").html(highlighted_smelly_code);
}
