$(document).ready(function() {
  listenselect();
  total();
});


$(document).on("price-changed",function() {
  total();
});


// METHODES

function listenselect(){
  $('.select-price[data-id]' ).change(
    function() {
      $(this).closest('form').submit();
    }
  )
};

function total(){
  sum = 0;
  $('.producer[data-id]').each(function(){
    var id = parseInt($(this).data('id'));
    sum = 0;
    $(".basket-line-price[data-producerid="+id+"]").each(function() {
      sum += parseInt($( this ).text());
    });
    $(".total[data-id="+id+"]").empty().text(sum);

    if (sum == 0){
      console.log(sum);
      console.log(id);
      $(".producer-group[data-id="+id+"]").remove();
    }
  });
};
