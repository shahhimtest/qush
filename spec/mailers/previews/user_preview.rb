# Preview all emails at http://localhost:3000/rails/mailers/user
class UserPreview < ActionMailer::Preview
  def email_confirmation
    UserMailer.email_confirmation(user)
  end

  private

  def user
    @user ||= User.first || FactoryGirl.create(:user)
  end
end
