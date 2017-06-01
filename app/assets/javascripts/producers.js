
// à factoriser avec l'ajout de data-id dans le markup

$(document).ready(function() {
  $("#to-step-2").on('click', goToProducerFormStep2);
  $("#to-step-3").on('click', goToProducerFormStep3);
  $("#to-step-4").on('click', goToProducerFormStep4);
});

function goToProducerFormStep2(event) {
  event.preventDefault();
  $('#form-producer-step-1').addClass('animated-short fadeOut');
  $('#form-producer-step-1').on("animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd", function(){
    $('#form-producer-step-1').addClass('hidden');
    $('#form-producer-step-1').removeClass('animated-short fadeOut');
    $('#form-producer-step-2').removeClass('hidden');
    $('#form-producer-step-2').addClass('animated-short fadeIn');
    $('#form-producer-step-2').on("animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd", function(){
      $('#form-producer-step-2').removeClass('animated-short fadeIn');
    });
  });
}

function goToProducerFormStep3(event) {
  event.preventDefault();
  $('#form-producer-step-2').addClass('animated-short fadeOut');
  $('#form-producer-step-2').on("animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd", function(){
    $('#form-producer-step-2').addClass('hidden');
    $('#form-producer-step-2').removeClass('animated-long fadeOut');
    $('#form-producer-step-3').removeClass('hidden');
    $('#form-producer-step-3').addClass('animated-short fadeIn');
    $('#form-producer-step-3').on("animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd", function(){
      $('#form-producer-step-3').removeClass('animated-short fadeIn');
    });
  });
}

function goToProducerFormStep4(event) {
  event.preventDefault();
  $('#form-producer-step-3').addClass('animated-short fadeOut');
  $('#form-producer-step-3').on("animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd", function(){
    $('#form-producer-step-3').addClass('hidden');
    $('#form-producer-step-3').removeClass('animated-long fadeOut');
    $('#form-producer-step-4').removeClass('hidden');
    $('#form-producer-step-4').addClass('animated-short fadeIn');
    $('#form-producer-step-4').on("animationend webkitAnimationEnd oAnimationEnd MSAnimationEnd", function(){
      $('#form-producer-step-4').removeClass('animated-short fadeIn');
    });
  });
}
