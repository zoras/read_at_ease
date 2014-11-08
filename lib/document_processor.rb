class DocumentProcessor
  attr_accessor :document, :user

  OUTPUT_PATH = 'public/processed_documents'
  DEFAULT_PDF = 'public/documents/Goamjuly2008.pdf'

  def initialize(user_hash:, document: DEFAULT_PDF)
    @document = document
    @user = get_user(user_hash)
  end

  def split_doc
    extra_options = { size: '1000x',
                      format: [:png],
                      output: "#{OUTPUT_PATH}/#{user.id}/#{get_file_name}" }
    Docsplit.extract_images(document, extra_options)
  end

  def get_file_name
    File.basename(document, '.*')
  end

  # returns either user object or just info hash
  def get_user(user_hash)
    user_hash = user_hash.with_indifferent_access
    user = User.find_or_initialize_by(email: user_hash['email'])
    user if user.save(validate: false)
  end
end
