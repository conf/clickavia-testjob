class ClickaviaTestJob.Models.Flight extends Backbone.Model
  paramRoot: 'flight'

class ClickaviaTestJob.Collections.FlightsCollection extends Backbone.Collection
  model: ClickaviaTestJob.Models.Flight
  url: '/parsers/flights'
