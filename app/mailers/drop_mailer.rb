class DropMailer < ActionMailer::Base
  default :from MY_EMAIL

  def send_drop_mail(mail)
  	mail(:to => MY_EMAIL, 
  		 :subject => "Driver Drop test email")
  end
end
