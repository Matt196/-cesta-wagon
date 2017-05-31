$(document).ready(function() {
  $("#to-step-2").on('click', goToProducerFormStep2);
  $("#to-step-3").on('click', goToProducerFormStep3);
});

function goToProducerFormStep2(event) {
  event.preventDefault();
  $('#form-producer-step-1').addClass('animated-long zoomOut');
  $('#form-producer-step-1').on("animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd", function(){
    $('#form-producer-step-1').addClass('hidden');
    $('#form-producer-step-1').removeClass('animated-long zoomOut');
    $('#form-producer-step-2').removeClass('hidden');
    $('#form-producer-step-2').addClass('animated-short fadeIn');
    $('#form-producer-step-2').on("animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd", function(){
      $('#form-producer-step-2').removeClass('animated-short fadeIn');
    });
  });
}

function goToProducerFormStep3(event) {
  event.preventDefault();
  $('#form-producer-step-2').addClass('animated-long zoomOut');
  $('#form-producer-step-2').on("animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd", function(){
    $('#form-producer-step-2').addClass('hidden');
    $('#form-producer-step-2').removeClass('animated-long zoomOut');
    $('#form-producer-step-3').removeClass('hidden');
    $('#form-producer-step-3').addClass('animated-short fadeIn');
    $('#form-producer-step-3').on("animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd", function(){
      $('#form-producer-step-3').removeClass('animated-short fadeIn');
    });
  });
}
