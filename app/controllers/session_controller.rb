class SessionController < ApplicationController

  def create
    email = request.env['omniauth.auth'].info.to_hash['email']
    if email =~ /@(the)?edgecase.com\Z/
      flash.notice = "Authorized as #{email}"
    else
      flash.alert = "#{email} not authorized!"
    end
    redirect_to request.env['omniauth.origin'] || root_path
  end

end
