class Contact < MailForm::Base
  attribute :first_name,      :validate => true
  attribute :last_name,       :validate => true
  attribute :email,           :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :entity_name,     :validate => true
  attribute :entity_site
  attribute :message,         :validate => true

  attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => "#{first_name} #{last_name}\'s inquiry about KMF",
      # Change BEFORE this goes into production
      :to => "kellogg.kindling@gmail.com",
      :from => %("#{first_name} #{last_name}" <#{email}>)
    }
  end
end
