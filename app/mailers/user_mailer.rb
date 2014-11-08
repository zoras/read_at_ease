class UserMailer < ActionMailer::Base
  default from: "no-reply@eread-at-ease.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://read-at-ease.com/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to Read at Ease')
  end

  # user = User.first
  # snippet_path = "#{Rails.root}/public/processed_documents/545db6196b73683ec6000000/factory_girl_tutorial/factory_girl_tutorial_1.jpg"

  # mail = UserMailer.mail_snippet(user, snippet_path).deliver!
  def mail_snippet(user, snippet_path)
    @user = user

    @file_name = File.basename(snippet_path)
    attachments.inline[@file_name] = File.read(snippet_path)

    mail(to: @user.email, subject: "Read at Ease - Today's feed")
  end
end
