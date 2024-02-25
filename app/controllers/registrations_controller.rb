class RegistrationsController < ApplicationController
  skip_before_action :require_user, only: [:new, :create]
    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
          redirect_to dashboard_path, notice: "User created successfully."
        else
          # Respond to Turbo Stream requests
          respond_to do |format|
            format.html { render :new, status: :unprocessable_entity }
            format.turbo_stream do
              render turbo_stream: turbo_stream.replace("form_errors", partial: "layouts/form_errors", locals: { user: @user }), 
                     status: :unprocessable_entity
            end
          end
        end
      end
      
      

    private

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end