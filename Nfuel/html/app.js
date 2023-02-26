window.addEventListener('message', function(event) {

    var v = event.data

    switch(v.action) {
      case 'show':
      ShowNfuel()
      break;
      case 'hide':
      HideNfuel()
      break
  }
})

function ShowNfuel() {

    $('.container').fadeIn()
    openUI = true
}

function HideNfuel() {

  $('.container').fadeOut()
  openUI = false
}

$(document).ready(function () {
    window.addEventListener("message", function (event) {
      if (event.data.type == "menu") {
        event.data.status
          ? (document.body.style.opacity = "1")
          : (document.body.style.opacity = "0");
        
          } else if (event.data.action == 'prix') {
            $('#prix').html("<i class='fa-regular fa-circle-dollar'></i> Prix au litre : "+event.data.prix + " $");
          } else if (event.data.action == 'vehicle') {
            $('#vehicule').html("<i class='fa-solid fa-car'></i> Vehicule : "+event.data.vehicle);
          } else if (event.data.action == 'reservoir'){
            $('#capaciter').html("<i class='fa-regular fa-battery-full'></i> Capaciter : "+event.data.reservoir +" L");
          } else if (event.data.action == 'litreactuel') {
            $('#litre-actuel').html("<i class='fa-regular fa-oil-can-drip'></i> Litre actuel : "+ event.data.litreactuel + " L");
          } else if (event.data.action == 'compfuel') {
            if(compfuel >= 100) {
              tanken();
            }
            $('#compfuel').html(event.data.compfuel + " L");
          } else if (event.data.action == 'tankpreis') {
            $('#tankpreis').html(event.data.tankpreis);
          }


      }  
    
    )}
    
      
    );


function closemenu() {
    $.post(`https://Nfuel/closeMenu`);
    $('.container').fadeOut()
    openUI = false
}

function plein100() {
    $.post(`https://Nfuel/Plein100`);
}

function plein50() {
    $.post(`https://Nfuel/Plein50`);
}
$('#btn-plein2').click(function (e) {
  e.preventDefault();
  $.post('http://Nfuel/plein', JSON.stringify({
      amountw: $('#nombre').val()
  }));
  $('#nombre').val('');
  $('.container').fadeOut()
  openUI = false
});




    