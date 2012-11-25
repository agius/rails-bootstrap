class ApplicationController < ActionController::Base
  protect_from_forgery
  
  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception, with: :render_500
    rescue_from ActionController::RoutingError, with: :render_404
    rescue_from ActionController::UnknownController, with: :render_404
    rescue_from AbstractController::ActionNotFound, with: :render_404
    rescue_from ActiveRecord::RecordNotFound, with: :render_404
  end

  private
  def render_404(exception)
    log_error(exception)
    @exception = exception
    @not_found_path = exception.message
    render nothing: true, status: 404 and return false if request.xhr?
    respond_to do |format|
      format.html { render template: 'errors/error_404', layout: 'layouts/application', status: 404 }
      format.all { render nothing: true, status: 404 }
    end
  end

  def render_500(exception)
    log_error(exception)
    @exception = exception
    @error = exception
    render nothing: true, status: 500 and return false if request.xhr?
    respond_to do |format|
      format.html { render template: 'errors/error_500', layout: 'layouts/application', status: 500 }
      format.all { render nothing: true, status: 500}
    end
  end
  
  def log_error(e)
    Rails.logger.debug(e.inspect)
    Rails.logger.debug(e.message)
    Rails.logger.debug(e.backtrace.join("\n"))
  end
end