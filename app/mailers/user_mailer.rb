class UserMailer < ApplicationMailer
  default from: "kellogg-kindling@gmail.com"
  def welcome_email(user,pwd)
    @user = user
    @pwd = pwd
    @url  = "https://kellogg-kindling.herokuapp.com/"
    mail(to: @user.email, subject: "Access to Kellogg Kindling")
    puts("SENT WELCOME_EMAIL to " + @user.email.to_s)
  end
end
