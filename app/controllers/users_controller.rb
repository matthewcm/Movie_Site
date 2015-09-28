class UsersController < ApplicationController
    before_action :ensure_admin, only: [:index]
    def index
        @users = User.all
    end
    def new
        @user = User.new
    end
    def update
        @user = User.find(params[:id])
        @user.update(user_params)
        flash[:notice] = "The password was updated. "
        redirect_to user_path(@user)
    end
    def create
        @user = User.new(user_params)
        @user.level = 1
        if(@user.save)
            log_in(@user)
            flash[:success] = "Welcome to Matt's Movies!"
            redirect_to user_path(@user)
        else
            render :new
        end
    end

    def show
        @user = User.find(params[:id])
    end

    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    def ensure_admin
        if current_user.level == 3
            puts 'Hello Admin'
        else
            redirect_to user_path(current_user.id)
        end
   end
end
