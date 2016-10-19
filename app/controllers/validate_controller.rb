class ValidateController < ApplicationController
	

	def index
	  @session = Session.where(:token => params[:token]).first
      #session = Session.where("user_id =#{user_id} and token='#{token}'")
      if !@session.nil?
         notice = {:status => 201, :message => "User Already Logged In"}
         render :json => notice
      else
        msg = {:status => 401, :message => "Please Log In"}
        render :json => msg
      end
	end



end
