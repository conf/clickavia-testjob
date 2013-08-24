$(document).ready ->
  $('table').dataTable({
    sDom: 'lrtip'
    bProcessing: true
    bServerSide: true
    sAjaxSource: '/flights'
    aoColumns: [
      { mDataProp: 'depart_airport' }
      { mDataProp: 'arrive_airport' }
      { mDataProp: 'code' }
      { mDataProp: 'depart_date' }
      { mDataProp: 'depart_time' }
      { mDataProp: 'arrive_time' }
      { mDataProp: 'seats_status' }
    ]
    fnInitComplete: (oSettings, json) ->
      datatable = @
      $('.filters input[type=search], .filters input[type=text]').on 'change', ->
        $el = $(@)
        datatable.fnFilter $el.val(), $(".filters th").index($el.parent())
  })


