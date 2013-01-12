class SessionsController < ApplicationController
  helper SessionsHelper

  def create
    user = User.find_by_eMail(params[:e_mail].downcase)
    if user && user.authenticate(params[:password])
      cookies[:remember_token] = { value:   user.remember_token,
                                   expires: 2.days.from_now.utc }
      self.current_user = user
 
      render json: "Signed in correctly.", status: 200
    else
      render json: "Invalid e-mail/password combination!", status: 401
    end
  end
  
  def destroy
    if signed_in?
      self.current_user = nil
      cookies.delete(:remember_token)
      
      render json: "Signed out correctly.", status: 200
    else
      render json: "No user logged in!", status: 401
    end
  end
end
