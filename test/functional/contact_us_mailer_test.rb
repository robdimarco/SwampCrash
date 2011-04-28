require 'test_helper'

class ContactUsMailerTest < ActionMailer::TestCase
  test "Can send contact us mail" do
    message = ContactUs.new :name=>"Foo Bar", :email=>"Bogus@foo.com", :subject=>"Test", :message=>"Message"
    assert_difference "ActionMailer::Base.deliveries.length" do
      email = ContactUsMailer.contact_us(message).deliver
      # Test the body of the sent email contains what we expect it to
      assert_equal [[%w(robdimarco swampcrash contactus).join("+"), %w(gmail com).join(".")].join(64.chr)], email.to
      assert_equal "Test", email.subject
    end    
  end
end
