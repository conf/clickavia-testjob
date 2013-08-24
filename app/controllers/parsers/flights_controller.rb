class Parsers::FlightsController < ApplicationController
  layout 'parsers/application'

  def index
    respond_to do |format|
      format.html
      format.json { render json: Flight.all }
    end
  end
end
