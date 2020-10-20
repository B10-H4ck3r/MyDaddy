class BabiesController < ApplicationController

  before_action :logged_in_baby, only: [:index, :edit, :update, :destroy]
  before_action :correct_baby,   only: [:edit, :update]
  before_action :admin_baby,     only: :destroy


  def index
    @babies = Baby.paginate(page: params[:page])
  end

    def show
      @baby = Baby.find(params[:id])
    end

    def new
      @baby = Baby.new
    end

    def create
      @baby = Baby.new(baby_params)
      if @baby.save
        reset_session
        log_in @baby
        flash[:success] = "Welcome to MyDaddy!"
        redirect_to @baby
      else
        render 'new'
      end
    end

    def edit
      @baby = Baby.find(params[:id])
    end

    def update
      @baby = Baby.find(params[:id])
      if @baby.update(baby_params)
        flash[:success] = "Profile updated"
        redirect_to @baby
      else
        render 'edit'
      end
    end

    def destroy
      Baby.find(params[:id]).destroy
      flash[:success] = "Sugar Baby deleted"
      redirect_to babies_url
    end

    private

      def baby_params
        params.require(:baby).permit(:name, :email, :password, :password_confirmation)
      end

      # Confirms a logged-in user.
      def logged_in_baby
        unless logged_in?
          store_location
          flash[:danger] = "Please log in."
          redirect_to login_url
        end
      end

      # Confirms the correct user.
      def correct_baby
        @baby = Baby.find(params[:id])
        redirect_to(root_url) unless current_baby?(@baby)
      end

      # Confirms an admin user.
      def admin_baby
        redirect_to(root_url) unless current_baby.admin?
      end

end
