class DocumentProcessor
  attr_accessor :document, :user

  def initialize(document, user_hash)
    @document = document
    @user = get_user(user_hash)
  end

  def split_doc
    Docsplit.extract_images(document, size: '1000x', format: [:png, :jpg], output: 'public/processed_documents')
  end

  # returns either user object or just info hash
  def get_user(user_hash)
    user = User.find_or_initialize_by(email: user_hash['email'])
    user if user.save
  end
end
