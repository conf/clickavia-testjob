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
    fnServerParams: (aoData) ->
      aoData.push(
        { name: 'depart_date_from', value: $('.depart_date .from').val() },
        { name: 'depart_date_to', value: $('.depart_date .to').val() }
      )

    fnInitComplete: (oSettings, json) ->
      datatable = @
      $('.filters input, .filters select').on 'change', ->
        $el = $(@)
        datatable.fnFilter $el.val(), $(".filters th").index($el.parent())
  })

  $('.depart_date .from').datepicker({
    defaultDate: '2014-01-01'
    changeMonth: true
    dateFormat: "yy-mm-dd"
    onClose: (selectedDate) ->
      $('.depart_date .to').datepicker( "option", "minDate", selectedDate )
  })

  $('.depart_date .to').datepicker({
    defaultDate: '2014-01-07'
    changeMonth: true
    dateFormat: "yy-mm-dd"
    onClose: (selectedDate) ->
      $('.depart_date .from').datepicker( "option", "maxDate", selectedDate );
  })


