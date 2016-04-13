class ContactMailer < ActionMailer::Base
    default to 'andrew.wipf09@gmail.com'
    
    def contact_email(name, email, body)
        @name = name
        @email = email
        @body = body
        
        mail(to: "andrew.wipf09@gmail.com", from: email, subject: "Contact Form Message")
    end
end