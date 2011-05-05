$(document).ready(function() {
  $('td.comment').hover(function() {
    $(this).children('.commentActions').show();
  }, function() {
    $(this).children('.commentActions').hide();
  });
});