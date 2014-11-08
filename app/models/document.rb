require_relative '../uploaders/ebook_uploader'

class Document
  include Mongoid::Document

  ## Attributes
  field :title,             type: String
  field :location,          type: String, default: DocumentProcessor::OUTPUT_PATH
  field :customized_time,   type: Time, default: nil
  field :completed_reading, type: Boolean, default: false
  field :snippets,          type: Array, default: []
  field :track_head,        type: Integer, default: 0 #upcoming snippet
  field :ebook, 			type: String

  ## Association
  belongs_to :user

  ## Uploads
  mount_uploader :ebook, EbookUploader

  def next_snippet_to_read
    if track_head < snippets.count
      file_name = snippets[track_head]
    else
      self.completed_reading = true
      self.save
    end
  end

  def update_track_head
    self.track_head += 1
    self.save
  end
end
