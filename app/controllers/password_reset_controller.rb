class PasswordResetController < ApplicationController
	before_action :set_user, only: [:update]
  def create 
        @user = User.find_by_email(params[:email])
        if !@user.nil?
          PasswordMailer.password_mailer(@user).deliver_later
          msg = {:status => 200, :message =>"password reset", :email => @user.email}
          return render :json => msg
         else
            render json:@user, status: 304
        end
  end

  	#put or patch
	def update
    @user = User.find_by_email(params[:email])
    if !@user.nil?
        if @user.update(user_params)
        msg = {:status => 200, :message => "password updated"}
        render :json => msg
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    else
      notice = {:status => 404, :message => "User Does not Exist"}
      render :json => notice
    end
	end

private

def user_params
      params.require(:user).permit(:password, :password_confirmation)
 end

def reset_params
  params.require(:user).permit(:email)
end

end
