class UsersController < ApplicationController
  def all
    users = User.all

    render json: users
  end

  def get
    user = User.find(params[:id])

    render json: user
  end

  def create
    if signed_in?
      render json: "You have to sign out to register new users!", status: 401
    else
      User.create(firstName: params[:first_name],
                  secondName: params[:second_name],
                  email: params[:email],
                  description: params[:description],
                  password: params[:password],
                  password_confirmation: params[:password_confirmation])
      
      render json: :nothing, status: 200
    end
  end
  
  def update
    if signed_in?
      user = current_user

      User.update(firstName: params[:first_name],
                  secondName: params[:second_name],
                  email: params[:email],
                  description: params[:description],
                  password: params[:password],
                  password_confirmation: params[:password_confirmation])
      
      render json: :nothing, status: 200
    else
      render json: "Guest can't update users!", status: 401
    end
  end

  def destroy
    if signed_in?
      user = current_user
      
      user.delete
      
      render json: :nothing, status: 200
    else
      render json: "Gust can't delete users!", status: 401
    end
  end
end
