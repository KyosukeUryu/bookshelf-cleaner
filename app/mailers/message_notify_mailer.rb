class MessageNotifyMailer < ApplicationMailer
  def message_notify_mail(sender, recipient)
    @sender = sender
    @recipient = recipient

    mail to: @recipient.email, subject: "メッセージが届きました"
  end
end
