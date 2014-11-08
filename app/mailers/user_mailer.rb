class UserMailer < ActionMailer::Base
  default from: "no-reply@eread-at-ease.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://read-at-ease.com/users/sign_in'
    mail(to: @user.email, subject: 'Welcome to Read at Ease')
  end

  # user = User.first
  # snippet_path = "/Users/zoras/code/read_at_ease/public/processed_documents/545dc5687a6f721ddd000000/Goamjuly2008/Goamjuly2008_1.png"
  # mail = UserMailer.mail_snippet(user, snippet_path).deliver!
  def mail_snippet(user, snippet_path)
    @user = user

    @file_name = File.basename(snippet_path)
    attachments.inline[@file_name] = File.read(snippet_path)

    mail(to: @user.email, subject: "Read at Ease - Today's feed")
  end
end
