$(document).ready(function() {
  $("#to-step-2").on('click', goToProducerFormStep2);
  $("#to-step-3").on('click', goToProducerFormStep3);
});

function goToProducerFormStep2(event) {
  console.log('try to go to step 2');
  event.preventDefault();
  $('#form-producer-step-1').addClass('hidden');
  $('#form-producer-step-2').removeClass('hidden');
}

function goToProducerFormStep3(event) {
  event.preventDefault();
  $('#form-producer-step-2').addClass('hidden');
  $('#form-producer-step-3').removeClass('hidden');
}
