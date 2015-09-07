var PagesController = Paloma.controller('Pages');

PagesController.prototype.faq = function(){
  $('.faq-link').click(function(e){
    e.preventDefault();
    var element_id = $(this).attr('href');
    scroll_to_element(element_id, 500, -70)
  })
};
