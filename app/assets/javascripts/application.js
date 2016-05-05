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
//= require jquery.turbolinks
//= require bootstrap
//= require_tree
//= require turbolinks

var getAndProcessMarkdown = function() {
  var converter = new showdown.Converter();
  var markdown = $('#wiki_body').val();
  var html = converter.makeHtml(markdown);
  $('#wiki_preview').html(html);

  $('pre code').each(function(i, block) {
    hljs.highlightBlock(block);
  });
};

$(document).ready(function() {
  getAndProcessMarkdown();
  $('#wiki_body').on('keyup', function() {
    getAndProcessMarkdown();
  });
});
