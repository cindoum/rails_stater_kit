class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :set_csrf_cookie_for_ng
  rescue_from StandardError, :with => :runtime_error
  rescue_from CanCan::AccessDenied, :with => :rescue_cancan

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end
  
  def runtime_error(ex)
     Airbrake.notify(ex)
     render :status => 500, :json => FormatResponse.doFormat(false, "Something went wrong", ex)
  end
  
  def rescue_cancan(ex)
     Airbrake.notify(ex)
     render :status => 403, :json => FormatResponse.doFormat(false, "Access denied", ex)
  end
  
  protected
    def verified_request?
        super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
    end
        
end
