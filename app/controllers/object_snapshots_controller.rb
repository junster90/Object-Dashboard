class ObjectSnapshotsController < ApplicationController
  def create
    @result = ObjectSnapshotsBuilder.new(search_query_params).build

    respond_to do |format|
      @result ? format.js : format.js { render 'error' }
    end
  end

  private

  def search_query_params
    params.require(:search).permit(:object_id, :object_type, :timestamp)
  end
end
