$(function() {
  $('#mobile-filter-show').on('click', function() {
    $('#mobile-filter-container').css({'top':0});
    $('body').addClass('filter-opened');
  });

  $('#mobile-filter-hide').on('click', function() {
    $('#mobile-filter-container').css({'top': '100vh'});
    $('body').removeClass('filter-opened');
  });
});
