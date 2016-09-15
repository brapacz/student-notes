#= require bootstrap-datepicker

loadDatepicker = ->
  $('.datepicker').datepicker(format: 'yyyy-mm-dd')

$(document).ready(loadDatepicker)
$(document).on('page:load', loadDatepicker)
