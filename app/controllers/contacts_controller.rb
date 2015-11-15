class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(params[:contact])
    @contact.request = request
    if @contact.deliver
      flash.now[:notice] = 'Thank you for your interest in KMF. You\'ll be hearing back from us soon!'
    else
      flash.now[:error] = 'Error sending message. Please try again or send us an email to info@domain.com'
      # Not sure reloading is what we want to do
      render :new
    end
  end
end
