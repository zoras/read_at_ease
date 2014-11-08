class DailyCronJob
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  # recurring job, runs daily at midnight
  recurrence { daily }

  def perform
    Document.where(customized_time: nil, completed_reading: false).lazy.each do |document|
      snippet_path = document.next_snippet_to_read
      if UserMailer.mail_snippet(document.user, snippet_path).deliver
        document.update_track_head
      end
    end
  end
end
