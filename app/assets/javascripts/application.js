// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require_tree .

$(function(){

  if( $('#event_search_form').length > 0){

    $('#event_search_form').on('change', function() {
      $(this).submit();
    });

    $('#event_search_form').find('#clear_event_search').on('click', function(e) {
      e.preventDefault();

      var form = $(this).parents('form');
      form.find(':input').not(':button, :submit, :reset, :hidden, :checkbox, :radio').val('');
      form.find(':checkbox, :radio').prop('checked', false);

      form.submit();

      return false;
    });

    $('#event_search_form').find('#replay_events').on('click', function(e){
      e.preventDefault();

      if(!confirm("This will replay the whole collection filtered (ignoring pages). Are you sure you want to do this?"))
        return false;

      var url  = $(this).data('replay-url');
      var form = $(this).parents('form');
      form.attr('action', url);
      form.submit();

      return false;
    });
  }
});
