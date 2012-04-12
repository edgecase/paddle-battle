//= require jquery
//= require jquery.tabs
//= require_self

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

  var $matches = $('#matches')
    , show_match_scores = true;

  $matches.on('click', 'td.score', function(e){
    var $match = $(e.target).parent('tr');
    $match.find('.score').toggle();
  });

  $matches.on('click', 'th.score', function(e) {
    show_match_scores = !show_match_scores;
    $matches.find('td.match-score').toggle(show_match_scores);
    $matches.find('td.game-scores').toggle(!show_match_scores);
  });
});
