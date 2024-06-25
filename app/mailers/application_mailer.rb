class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'

  def approved_status(user)
    @user = user
    mail(to: user.email, subject: 'Your account has been approved.')
  end

  def denied_status(user)
    @user = user
    mail(to: user.email, subject: 'Your account has been denied.')
  end
end
