class DocumentsController < ApplicationController
  include Parser
  before_filter :init_document, only: [:index, :search]
  def index
    @documents =  Document.all
  end

  def create
    if params[:document] && params[:document][:content].present?
      @document = Document.new(content: params[:document][:content])
      if @document.save
        message = "Document was created successfully."
      else
        message = "There was an error."
      end
    else
      message = "Document content is empty"
    end

    flash[:notice] = message
  	redirect_to documents_path
  end

  def search
    @tokens = Parser.parse_text(params[:query])
    @documents = Document.search(params[:query])
    render :index
  end

  def init_document
    @document = Document.new
  end
end
