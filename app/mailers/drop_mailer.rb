class DropMailer < ActionMailer::Base
  default :from => ENV["MY_EMAIL"]

  def send_drop_mail(drop)
  	mail(:to => ENV["MY_EMAIL"], 
  		 :subject => "Driver Drop test email",
  		 :id => drop.id)
  	binding.pry
  end
end
