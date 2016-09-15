#= require dataTables/jquery.dataTables
#= require dataTables/bootstrap/3/jquery.dataTables.bootstrap

loadDatable = ->
  $('.datatable').DataTable
    ajax: true
    autoWidth: false
    pagingType: 'full_numbers'
    processing: true
    serverSide: true

$(document).ready(loadDatable)
$(document).on('page:load', loadDatable)

# Optional, if you want full pagination controls.
# Check dataTables documentation to learn more about available options.
# http://datatables.net/reference/option/pagingType
