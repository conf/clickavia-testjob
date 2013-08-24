ClickaviaTestJob.Views.Flights ||= {}

class ClickaviaTestJob.Views.Flights.FilterView extends Backbone.View
  template: JST["backbone/templates/flights/filter"]

  initialize: () ->
    @filters =
      start_date: ''
      end_date: ''

  render: ->
    @$el.html(@template(filters: @filters))
    @
