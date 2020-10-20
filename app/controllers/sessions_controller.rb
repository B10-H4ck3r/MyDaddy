class SessionsController < ApplicationController

  def new
  end

  def create
    baby = Baby.find_by(email: params[:session][:email].downcase)
    if baby&.authenticate(params[:session][:password])
      reset_session
      log_in baby
      redirect_to baby
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
  
end
