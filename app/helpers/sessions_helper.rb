module SessionsHelper

  # Logs in the given user.
  def log_in(baby)
    session[:baby_id] = baby.id
  end

  # Returns the current logged-in user (if any).
  def current_baby
    if session[:baby_id]
      @current_baby ||= Baby.find_by(id: session[:baby_id])
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_baby.nil?
  end

  # Logs out the current user.
  def log_out
    reset_session
    @current_baby = nil
  end

end
