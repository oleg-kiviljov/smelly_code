$(document).on("ready page:load", (function(){
  $('.faq-link').click(function(e){
    e.preventDefault();
    var element_id = $(this).attr('href')
    scroll_to_element(element_id, 500, -70)
  })
}));