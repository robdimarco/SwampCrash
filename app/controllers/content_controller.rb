class ContentController < ApplicationController
  def contact_us
    @contact_us = ContactUs.new(params[:contact_us])
    if request.post? and @contact_us.valid?
      ContactUsMailer.contact_us(@contact_us).deliver
      flash[:notice] = "Thanks for your inquiry, we will get back to you shortly"
      redirect_to content_path(:action=>:contact_us) and return
    end
  end
end
