class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  rescue_from ActiveRecord::StatementInvalid, :with => :my_custom_error_handler
  
  def search_params
  params[:q]
  end
 
  def clear_search_index
      if params[:search_cancel]
        params.delete(:search_cancel)
          if(!search_params.nil?)
            search_params.each do |key, param|
              search_params[key] = nil
            end
          end
       end
  end
  
  
  ##### CHECK STORE IN SESSION  ####
  
  def get_query(cookie_key)
    cookies.delete(cookie_key) if params[:clear]
    cookies[cookie_key] = params[:q].to_json if params[:q]
    @query = params[:q].presence || JSON.load(cookies[cookie_key])
  end
  
  
    protected

    def my_custom_error_handler(exception)
      render "error"
    end
  
  
  
  
end
