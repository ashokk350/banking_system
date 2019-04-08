class UserMailer < ApplicationMailer
	default from: 'notifications@example.com'
 
  def deliver_email(user, transaction, mode)
    @user = user
    @transaction = transaction
    @mode = mode
    mail(to: @user.email, subject: 'Transaction Alert from bank!')
  end
end
