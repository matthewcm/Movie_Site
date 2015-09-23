class SessionsController < ApplicationController
      def new
    end

    def create
        user = User.find_by(email: params[:email].downcase)
        if user && user.authenticate(params[:password])
            log_in(user)
            redirect_to user_path(user)
        else
            flash.now[:alert] = "Invalid email or password"
            render 'new'
        end
    end

    def destroy
        log_out
        redirect_to root_url
    end
end
