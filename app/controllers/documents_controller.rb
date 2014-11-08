class DocumentsController < ApplicationController
  def upload
  	@document = Document.new
  end

  def create
  	# require 'pry'
  	# binding.pry

  	ebook_uploader = EbookUploader.new
  	ebook_uploader.store!(params["document"]["ebook"])

  	redirect_to root_path
  end


end
