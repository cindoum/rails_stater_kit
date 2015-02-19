class ApplicationController < ActionController::Base
  protect_from_forgery
  after_filter :set_csrf_cookie_for_ng
  
  rescue_from Exception do |e|
     error(e) 
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end
  
  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end
  
  def permission_denied
    render :file => "public/401.html", :status => :unauthorized
  end
  
  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end
  
  protected
    def verified_request?
        super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
    end
    
    def error(e)
        if e.class == CanCan::AccessDenied
            err_info = { :success => false,  :info => "#{e.class.name}", :data => "#{e.message}", :meta => { :trace => e.backtrace[0, 10]}}
            render :status => 403, :json => err_info.to_json 
        else 
            guid = Airbrake.notify(e)
            err_info = { :success => false,  :info => "#{e.class.name}", :data => "#{e.message}", :meta => {:guid => guid, :trace =>  e.backtrace[0, 10]}}
            render :status => 500, :json => err_info.to_json 
        end
    end
        
end
