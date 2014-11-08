class HomeController < ApplicationController
  def index
  end

  def about
  end

  def try_now
    email = params['email']
    dp = DocumentProcessor.new(user_hash: {email: email})
    dp.split_doc
    first_process
    redirect_to root_path, notice: 'Thanks for trying. Check your mail.'
  end

  def first_process
    Document.where(customized_time: nil, completed_reading: false).all.each do |document|
      snippet_path = document.next_snippet_to_read
      if UserMailer.mail_snippet(document.user, snippet_path).deliver
        document.update_track_head
      end
    end
  end

end
