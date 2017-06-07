$(function() {
  $('#mobile-filter-show').on('click', function() {
    $('#mobile-filter-container').css({'top':0});
  });
  $('#mobile-filter-hide').on('click', function() {
    $('#mobile-filter-container').css({'top': '100vh'});
  });
});
