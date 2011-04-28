class ContactUsMailer < ActionMailer::Base
  default :to => %w(contactus swampcrash.com).join("@")
  
  def contact_us(message)
    @message = message
    mail( :subject => @message.subject, :from => @message.email)
  end
end
