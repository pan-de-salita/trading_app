class UserMailer < ApplicationMailer
  def approved_status(user)
    p 'RRRRRRRRRRRRRRRRRRRRRRRRRRR'
    p user
    p 'RRRRRRRRRRRRRRRRRRRRRRRRRRR'
    mail(to: user.email, subject: 'Your account has been approved.')
  end

  def denied_status(user)
    p 'RRRRRRRRRRRRRRRRRRRRRRRRRRR'
    p user
    p 'RRRRRRRRRRRRRRRRRRRRRRRRRRR'
    mail(to: user.email, subject: 'Your account has been denied.')
  end
end
