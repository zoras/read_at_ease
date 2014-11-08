class DocumentProcessor
  attr_accessor :document, :user

  OUTPUT_PATH = 'public/processed_documents'


  def initialize(document, user_hash)
    @document = document
    @user = get_user(user_hash)
  end

  def split_doc
    Docsplit.extract_images(document, size: '1000x', format: [:png, :jpg], output: "#{OUTPUT_PATH}/#{user.id}")
  end

  # returns either user object or just info hash
  def get_user(user_hash)
    user_hash = user_hash.with_indifferent_access
    user = User.find_or_initialize_by(email: user_hash['email'])
    user if user.save(validate: false)
  end
end
