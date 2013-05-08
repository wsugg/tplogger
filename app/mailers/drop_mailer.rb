class DropMailer < ActionMailer::Base
  default :from "will.sugg@amd.com"

  def send_drop_mail(mail)
  	mail(:to => default, :subject => "test email")
  end
end
