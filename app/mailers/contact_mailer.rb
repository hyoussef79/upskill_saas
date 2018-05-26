class ContactMailer < ActionMailer::Base
  default to: 'hesham_youssef@yahoo.com'
  def contact_email(name, email, body)
    @name = name
    @email = email
    @body = body
    mail(from: email, subject: 'Contact Form Message')
  end
end
