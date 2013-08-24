class ClickaviaTestJob.Routers.FlightsRouter extends Backbone.Router
  initialize: (options) ->
    @flights = new ClickaviaTestJob.Collections.FlightsCollection()

  routes:
    "index"    : "index"
    ".*"        : "index"

  index: ->
    $.when(@flights.fetch()).done =>
      @view = new ClickaviaTestJob.Views.Flights.IndexView(collection: @flights)
      $("#flights").html(@view.render().el)
