class ApplicationController < ActionController::Base
  protect_from_forgery

  def routing_error
    render :file => "#{Rails.root}/public/404", :status => 404
  end

  def thanks(options = {})

    if options != ''
      @name = options.split(' ')
      @name = @name.first + ' ' + @name.last
    end


    render 'thanks'
  end


end