ActionMailer::Base.smtp_settings = {
  :address              => ENV["SMTP_GMAIL"],
  :port                 => 587,
  :domain               => ENV["MY_EMAIL_DOMAIN"],
  :user_name            => ENV["MY_EMAIL_USER"],
  :password             => ENV["MY_EMAIL_PASSWORD"],
  :authentication       => "plain",
  :enable_starttls_auto => true
}