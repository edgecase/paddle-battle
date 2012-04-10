$(document).ready( function(){
  $('.tab-bar').tabs();
  
  // Hide flash messages after 30 seconds
  window.setTimeout(function() {  
    $('#flash-messages').hide();
  }, 30000);

  $('#new_match #winner .score').on('focus', function(e) {
    var score = $(e.target).val();
    if(!score){
      $(e.target).val('11');
    }
  });

  $('#matches').on('click', '.score', function(e){
    var $match = $(e.target).parent('tr');
    $match.find('.match-score').toggle();
    $match.find('.game-scores').toggle();
  });
});
