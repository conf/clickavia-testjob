ClickaviaTestJob.Views.Flights ||= {}

class ClickaviaTestJob.Views.Flights.IndexView extends Backbone.View
  template: JST["backbone/templates/flights/index"]

  initialize: () ->
    @collection.on 'reset', @render

    @filterView = new ClickaviaTestJob.Views.Flights.FilterView()
    @filterView.on 'filters:parse', @parse

  addAll: () =>
    @collection.each(@addOne)

  addOne: (flight) =>
    view = new ClickaviaTestJob.Views.Flights.FlightView({model : flight})
    @$("tbody").append(view.render().el)

  assign: (view, selector)->
    view.setElement(@$(selector)).render()

  parse: =>
    $.post "#{@collection.url}/parse", @filterView.filters, (data)=>
      @collection.reset data

  render: =>
    $(@el).html(@template())
    @addAll()
    @assign @filterView, '.filters'

    @
