// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

jQuery(document).ready(function($) {
  var replace = function(tokens) {
  	console.log(tokens);
    $.each(tokens, function(i, token){
      $('.content').each( function(){
        var text = $(this).html();
        var rgxp = new RegExp('(' + token + ')', 'gi');

        var newText = text.replace(rgxp, '<span class="highlight">$1</span>');
        $(this).html(newText);
      });
    });
  }

  var tokenElement = $('#tokens');

  if(tokenElement.length){
    var tokenStr = tokenElement.val();
    var tokens = tokenStr.split(',');
    replace(tokens);
  }
});