class UserMailer < ApplicationMailer
  def email_confirmation(user)
    @user = user

    mail to: user.email, subject: 'Welcome on Qush!'
  end
end
