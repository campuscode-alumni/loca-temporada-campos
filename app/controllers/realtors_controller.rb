class RealtorsController < ApplicationController
  def index
    @properties = Property.all

  end

end

