$(document).on('click', '.panel div.clickable', function (e) {
  var $this = $(this);
  if ($this.hasClass('panel-collapsed')) {
    $this.parents('.panel').find('.panel-body').slideDown();
    $this.removeClass('panel-collapsed');
    $this.find('i:eq(1)').removeClass('fa-plus').addClass('fa-minus');
  } else {
    $this.parents('.panel').find('.panel-body').slideUp();
    $this.addClass('panel-collapsed');
    $this.find('i:eq(1)').removeClass('fa-minus').addClass('fa-plus');
  }
});

$(document).on("ready page:load", function(){
  $('.panel-heading.clickable.panel-collapsed').parent('.panel').find('.panel-body').hide()
});
