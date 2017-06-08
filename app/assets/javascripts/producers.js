// Recharge la page producers avec les bons filtres
$(function() {
  $('#producer-filters form').on('submit', reloadProductList);
  $('#producer-filters [type="checkbox"], #producer-filters [type="radio"]').on('change', function() {
    $(this).closest('form').submit();
  });
  $('#mobile-filter-body form').on('submit', reloadProductList);
  $('#mobile-filter-body [type="checkbox"], #mobile-filter-body [type="radio"]').on('change', function() {
    $(this).closest('form').submit();
  });
});

$(document).on('ready ajaxComplete', displayDistanceFromUserLocation);

function reloadProductList(event) {
  event.preventDefault();
  $('#list-loader').removeClass('hidden');
  var uriParameters = $(this).serialize();
  history.pushState({}, {}, '?' + uriParameters); // met à jour l'url avec les paramètres de la recherche
  var url = "/producers?" + uriParameters;
  request = $.get(url, function(data) {
    var $html = $(data).find('#producer-list');
    $('#producer-list').html($html.html());
  });
}

function displayDistanceFromUserLocation() {
  var userLocation = $('#cards').data('location');
  var producersLocation = [];
  $.each($('.producer-card'), function(index, value) {
    producersLocation.push($(this).data('latitude') + ', ' + $(this).data('longitude'));
  });
  getDistanceFromGmapAPI(userLocation, producersLocation);
}

function getDistanceFromGmapAPI(userLocation, producersLocation) {
  var service = new google.maps.DistanceMatrixService();
  service.getDistanceMatrix(
    {
      origins: [userLocation],
      destinations: producersLocation,
      travelMode: 'DRIVING',
      avoidHighways: false,
      avoidTolls: false,
    }, callback);
}

function callback(response, status) {
  if (status == 'OK') {
    var origin = response.originAddresses[0];
    var destinations = response.destinationAddresses;
    var results = response.rows[0].elements;

    for (var i = 0; i < results.length; i++) {
      var element = results[i];
      var duration = element.duration.text.replace(' minutes', 'min').replace(' heures ', 'h').replace(' heure ', 'h');
      $('.producer-card-location').eq(i).append($('<span>').text(duration));
    }
  }
}



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
