class DocumentsController < ApplicationController
  include Parser
  before_filter :init_document, only: [:index, :search]
  def index
    @documents =  Document.all
  end

  def create
  	@document = Document.new(content: params[:document][:content])
  	if @document.save
  	  flash[:notice] = "Document was created successfully."
  	else
  	 flash[:error] = "There was an error."
  	end
  	redirect_to documents_path
  end

  def search
    @tokens = Parser.parse_text(params[:query])
    @documents =  Document.search(params[:query])
    render :index
  end

  def init_document
    @document = Document.new
  end
end
