ClickaviaTestJob.Views.Flights ||= {}

class ClickaviaTestJob.Views.Flights.FlightView extends Backbone.View
  template: JST["backbone/templates/flights/flight"]

  tagName: "tr"

  render: ->
    @$el.html(@template(@model.toJSON()))
    @
