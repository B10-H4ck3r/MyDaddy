class MicropostsController < ApplicationController

  before_action :logged_in_baby, only: [:create, :destroy]
  before_action :correct_baby,   only: :destroy

  def create
    @micropost = current_baby.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = current_baby.feed.paginate(page: params[:page])
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    if request.referrer.nil? || request.referrer == microposts_url
      redirect_to root_url
    else
      redirect_to request.referrer
    end
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content)
    end

    def correct_baby
      @micropost = current_baby.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end

end
