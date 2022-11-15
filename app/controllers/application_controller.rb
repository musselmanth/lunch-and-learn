class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found(exception)
    render json: ErrorSerializer.not_found(exception.message), status: :not_found
  end
end
