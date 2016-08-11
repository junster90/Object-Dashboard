class ObjectSnapshotsController < ApplicationController
  def create
    @result = ObjectSnapshotsBuilder.new(search_query_params).build

    render_result_or_error
  end

  private

  def search_query_params
    params.require(:search).permit(:object_id, :object_type, :timestamp)
  end

  def render_result_or_error
    respond_to do |format|
      @result ? format.js : format.js { render 'error' }
    end
  end
end
