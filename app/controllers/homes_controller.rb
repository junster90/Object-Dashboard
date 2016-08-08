class HomesController < ApplicationController
  def index
    @objects = ObjectRecord.all
  end
end
