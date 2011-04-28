class ContactUsMailer < ActionMailer::Base
  default :to =>[%w(robdimarco swampcrash contactus).join("+"), %w(gmail com).join(".")].join(64.chr)
  
  def contact_us(message)
    @message = message
    mail( :subject => @message.subject, :from => @message.email)
  end
end
