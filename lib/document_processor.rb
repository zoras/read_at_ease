class DocumentProcessor
  attr_accessor :source_document, :user

  OUTPUT_PATH = 'public/processed_documents'
  DEFAULT_PDF = 'public/documents/Goamjuly2008.pdf'

  def initialize(user_hash:, source_document: DEFAULT_PDF)
    @source_document = source_document
    @user = get_user(user_hash)
  end

  def split_doc
    snippets_path = "#{OUTPUT_PATH}/#{user.id}/#{get_file_name}"
    extra_options = { size: '1000x',
                      format: [:png],
                      output: snippets_path }
    if Docsplit.extract_images(source_document, extra_options)
      title = Docsplit.extract_title(source_document)
      split_snippets = Dir["#{snippets_path}/*.*"].sort
      Document.create(title: title, snippets: split_snippets)
    end
  end

  def get_file_name
    File.basename(source_document, '.*')
  end

  # returns either user object or just info hash
  def get_user(user_hash)
    user_hash = user_hash.with_indifferent_access
    user = User.find_or_initialize_by(email: user_hash['email'])
    user if user.save(validate: false)
  end
end
