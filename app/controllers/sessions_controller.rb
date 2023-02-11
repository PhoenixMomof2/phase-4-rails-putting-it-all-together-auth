class SessionsController < ApplicationController
  skip_before_action :authorize, only: :create

  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password]) #In the create action, if the user's username and password are authenticated
      session[:user_id] = user.id #save the user'd ID in the session hash
      render json: user #return a JSON response with an error message, and a status of 401 (Unauthorized)(in application controller authorize method) 
    else
      render json: { errors: ["Invalid username or password"] }, status: :unauthorized
    end
  end

  def destroy
    session.delete :user_id
    head :no_content
  end
end
