class SessionsController < ApplicationController
  helper SessionsHelper

  def create
    user = User.find_by_eMail(params[:e_mail].downcase)
    if user && user.authenticate(params[:password])
      sign_in user
    else
      
    end
    respond_to do |format|
      format.json { render json: user }
    end

  end

  def destroy
    sign_out

    render json: "OK"
  end

 
end
