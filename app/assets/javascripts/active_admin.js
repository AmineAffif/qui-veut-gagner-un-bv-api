//= require arctic_admin/base
//= require select2

$(document).on('turbolinks:load', function() {
  $('.select2').select2({
    width: '100%'
  });
});
