class UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_filter :logged_in, :except => [:create, :verify]
  # GET /users
  # def index
  #   @users = User.all
  #   render json: @users
  # end

  # GET /users/1
  # def show
  #   render json: @user
  # end

  def find
    @unique  = params[:uuid]
    @user = User.find_by(uuid: @unique)
    if !@user.nil?
      msg  = {:status => 200, :name => @user.name, :email => @user.email, :phone => @user.phone }
      render :json => msg
    else
      notice = {:status => 404, :message => "User Does not Exist"}
      render :json => notice
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.confirmation_link = confirmation_link!
    @user.uuid = unique_id!
    if @user.password == @user.password_confirmation
      if @user.save
        UserMailer.user_mailer(@user).deliver_later
        msg  = {:status => 200, :uuid => @user.uuid, :message => "User Created Please Verify to Continue"}
        return render :json => msg
      else
        render json: @user.errors, status: :unprocessable_entity
      end
    end
  end

  #GET/users/verify?link

  def verify
        @link = params[:link]
        @user = User.find_by(confirmation_link: @link)
          if !@user.nil?
              if @user.is_active == false
                # @user.is_active = true
                @user.update_attribute(:is_active, true)
                msg = {:status => 200, :message => "user activated"}
                return render :json => msg

               else

                  render json: 304
              end

          else

              render json: @user, status:404
          end  
  end 


  # PATCH/PUT /users/1
  def update
    @unique  = params[:uuid]
    @user = User.find_by(uuid: @unique)
    if !@user.nil?
        if @user.update(user_params)
        msg  = {:status => 200, :uuid => @user.uuid, :message => "User Details Updated"}
        return render :json => msg
        else
          render json: @user.errors, status: :unprocessable_entity
        end
    else
      notice = {:status => 404, :message => "User Does not Exist"}
      render :json => notice
    end
  end

  # DELETE /users/uuid
  def destroy
    @unique  = params[:uuid]
    @user = User.find_by(uuid: @unique)
    if !@user.nil?
      @user.destroy
      msg  = {:status => 200, :message => "User deleted successfully"}
      render :json => msg
    else
      notice = {:status => 404, :message => "User Does not Exist"}
      render :json => notice
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :confirmation_link, :is_active, :uuid)
    end
end
