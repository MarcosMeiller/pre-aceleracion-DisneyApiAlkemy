class UserMailer < ApplicationMailer
  default from: "apidisney@gmail.com"

  def signup_welcome(user)
    @user = user
    

    mail to:  @user.email, subject: "Welcome to the Disney Api"
  end
end
