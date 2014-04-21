function highlight_smelly_code(smelly_code, lexer){
  $.ajax({
    type: 'POST',
    url: '/snippets/highlight_code',
    data: { smelly_code: smelly_code, lexer: lexer }
  }).success(function(data){
        $("#smelly_body").empty().html(data.highlighted_code);
      })
}

function apply_filters(){
  var filters = $("#filters select").serialize();
  window.location.href = "/snippets?"+filters
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

