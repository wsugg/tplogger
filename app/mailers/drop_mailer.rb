class DropMailer < ActionMailer::Base
  default :from MY_EMAIL

  def send_drop_mail(mail)
  	mail(:to => default, 
  		 :subject => "Driver Drop test email")
  end
end
