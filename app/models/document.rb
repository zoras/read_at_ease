class Document
  include Mongoid::Document

  ## Attributes
  field :title,             type: String
  field :location,          type: String, default: DocumentProcessor::OUTPUT_PATH
  field :customized_time,    type: Time, default: nil
  field :completed_reading, type: Boolean, default: false

  ## Association
  belongs_to :user
end
