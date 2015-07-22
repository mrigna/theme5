class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

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
  
  def after_sign_in_path_for(resource)
    if current_user.dg.nil?
      user_path(current_user)
    else
    "/nodes/#{current_user.dg}/index"
    end
  end

    protected

    def my_custom_error_handler(exception)
      render "error"
    end
end
