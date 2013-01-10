class UsersController < ApplicationController
  def getUsers
    users = User.all

    respond_to do |format|
      format.json { render json: users }
    end
  end
end
