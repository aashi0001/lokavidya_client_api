class UserMailer < ApplicationMailer
default from: 'klotheskart@gmail.com'
 
  def user_mailer(user)
    @user = user
    @url  = 'http://klotheskart.com/login'
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
