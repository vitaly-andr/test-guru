class FeedbackMailer < ApplicationMailer
  def send_feedback(feedback)
    @feedback = feedback

    mail(to: 'vitaly.andr+test@gmail.com', subject: t('feedback_mailer.subject'))
  end
end
