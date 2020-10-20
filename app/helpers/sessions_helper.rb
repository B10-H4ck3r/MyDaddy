module SessionsHelper

  # Logs in the given baby.
  def log_in(baby)
    session[:baby_id] = baby.id
    session[:session_token] = baby.session_token
  end

  # Remembers a baby in a persistent session.
  def remember(baby)
    baby.remember
    cookies.permanent.encrypted[:baby_id] = baby.id
    cookies.permanent[:remember_token] = baby.remember_token
  end

  # Returns the current logged-in baby (if any).
  def current_baby
    if (baby_id = session[:baby_id])
      @current_baby ||= Baby.find_by(id: baby_id)
    elsif (baby_id = cookies.encrypted[:baby_id])
      baby = Baby.find_by(id: baby_id)
      if baby && baby.authenticated?(cookies[:remember_token])
        log_in baby
        @current_baby = baby
      end
    end
  end


    # Returns true if the given user is the current user.
    def current_baby?(baby)
      baby && baby == current_baby
    end


  # Returns true if the baby is logged in, false otherwise.
  def logged_in?
    !current_baby.nil?
  end

  # Logs out the current baby.
  def log_out
    reset_session
    @current_baby = nil
  end

  # Forgets a persistent session.
  def forget(baby)
    baby.forget
    cookies.delete(:baby_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current baby.
  def log_out
    forget(current_baby)
    reset_session
    @current_baby = nil
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
