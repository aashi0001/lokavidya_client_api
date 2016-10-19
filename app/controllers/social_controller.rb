class SocialController < ApplicationController
def create
		#@access_token = params[:access_token]
		key = HTTParty.get("https://graph.facebook.com/me", query: {
      	access_token: params[:access_token]}).parsed_response
      	render json: key
   #    	@user = User.new
 		# @user.name = key[:name]
 		# @user.email = key[:email]
   #  	if @user.save
	  #       msg  = {:status => 200, :message => "User Created Please Verify to Continue"}
	  #       return render :json => msg
   #    	else
	  #       render json: @user.errors, status: :unprocessable_entity
   #    end
end

end

