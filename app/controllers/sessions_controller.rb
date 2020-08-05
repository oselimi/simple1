class SessionsController < ApplicationController

    def new; end

    def create
        user = User.find_by(:email [:session][:email].downcase)
        if user && user.authenticate([:session][:password])
            log_in(user)
            redirect_to user
        else
            render :new
        end
    end
end
