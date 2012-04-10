$(document).ready( function(){
  $('.tab-bar').tabs();
  
  // Hide flash messages after 30 seconds
  window.setTimeout(function() {  
    $('#flash-messages').hide();
  }, 30000);
});
