class ThanksMailer < ApplicationMailer
	def thanks_mail(user)
    @user = user
	mail(to: @user.email, subject: 'Welcome to Our Application!')
  end
end
