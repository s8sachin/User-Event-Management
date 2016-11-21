class SessionsController < ApplicationController
def new
  # respond_to do | format | 
  #     format.js    
  #   end
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])

    if user
      session[:user_id] = user.id
      redirect_to new_user_event_path(user)
    else
      flash[:error] = "Invalid email or password"
      render "new"
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to welcome_url, :notice => "Logged out!"
  end
 
end
