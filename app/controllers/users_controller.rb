class UsersController < ApplicationController
  def all
    users = User.all

    respond_to do |format|
      format.json { render json: users }
    end
  end

  def get
    user = User.find(params[:id])

    respond_to do |format|
      format.json { render json: user }
    end
  end

  def create
    firstName   = params[:firstName]
    secondName  = params[:secondName]
    eMail       = params[:eMail]
    description = params[:description]
    
    User.create(firstName:   firstName,
                secondName:  secondName,
                eMail:       eMail,
                description: description)

    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
    end
  end
  
  def update
    firstName   = params[:firstName]
    secondName  = params[:secondName]
    eMail       = params[:eMail]
    description = params[:description]
    
    user = User.find(params[:id])

    user.firstName = firstName
    user.secondName = secondName
    user.eMail = eMail
    user.description = description

    user.save

    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
    end
  end

  def destroy
    user = User.find(params[:id])

    user.delete

    respond_to do |format|
      format.all { render :nothing => true, :status => 200 }
    end
  end
end
