class SessionController < ApplicationController

  def create
    # id,user_id,token
    user = User.find_by_email(params[:user][:email])
    @pass = params[:user][:password]
    if user.is_active == true
      if  user.password==@pass
          @token = generate_authentication_token!
          @session = Session.new
          @session.user_id = user.id
          @session.uuid = user.uuid
          @session.token = @token
            if @session.save
              msg = {:status => 200, :session_id => @session.id, :session_token => @session.token, :session_uuid => @session.uuid}
              return render :json => msg
            else
              render json: @session.errors, status: 406
            end
      else
        flash = {:status => 401, :message => "Password does not match"}
        return render :json => flash
      end
    else
      notice = {:status => 422, :message => "user not active"}
      return render :json => notice
    end
  end

  def destroy   
    @session  = Session.find(params[:id])
      if !@session.nil?
        @session.destroy
        msg  = {:status => 200, :message => "User logged out successfully"}
        render :json => msg
      else
        notice = {:status => 404, :message => "User Does not Exist"}
        render :json => notice
      end
  end


  private
  def user_params
    params.require(:user).permit(:email, :password, :uuid)
  end

  
end
