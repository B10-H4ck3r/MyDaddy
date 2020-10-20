class BabiesController < ApplicationController


    def show
      @baby = Baby.find(params[:id])
    end

    def new
      @baby = Baby.new
    end

    def create
      @baby = Baby.new(baby_params)
      if @baby.save
        flash[:success] = "Welcome to MyDaddy!"
        redirect_to @baby
      else
        render 'new'
      end
    end

    private

      def baby_params
        params.require(:baby).permit(:name, :email, :password, :password_confirmation)
      end

end
