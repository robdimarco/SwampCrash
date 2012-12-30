// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.qtip.js
//= require twitter/bootstrap
//= require_tree .
$(function() {
  $("[data-tooltip]").qtip({
  		content: {attr: 'data-tooltip'},
  		position: {
  			my: 'top left',
  			target: 'mouse',
  			viewport: $(window), // Keep it on-screen at all times if possible
  			adjust: {
  				x: 10,  y: 10
  			}
  		},
  		hide: {
  			fixed: true // Helps to prevent the tooltip from hiding ocassionally when tracking!
  		},
  		style: {classes: 'ui-tooltip-bootstrap'}
  	});
});