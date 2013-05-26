ActionMailer::Base.smtp_settings = {
  :address              => SMTP_GMAIL,
  :port                 => 587,
  :domain               => MY_EMAIL_DOMAIN,
  :user_name            => MY_EMAIL_USER,
  :password             => "",
  :authentication       => "plain",
  :enable_starttls_auto => true
}