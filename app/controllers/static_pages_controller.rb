class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @micropost  = current_baby.microposts.build
      @feed_items = current_baby.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def about
  end

  def contact
  end

  def subscribe
  end
end
