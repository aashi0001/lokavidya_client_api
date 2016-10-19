class ApplicationController < ActionController::API
require 'digest/sha1'
require 'securerandom'

    def generate_authentication_token!
       return Digest::SHA1.hexdigest([Time.now, rand].join)
    end


  def confirmation_link!
    return SecureRandom.urlsafe_base64(20)
  end 
  
  def unique_id!
    return SecureRandom.urlsafe_base64(20)
  end

    def logged_in
      @session = Session.where(:token => params[:token]).first
      #session = Session.where("user_id =#{user_id} and token='#{token}'")
      if !@session.nil?
         return true
      else
        msg = {:status => 401, :message => "not authorized"}
        render :json => msg
         return false 
      end
    end


end
