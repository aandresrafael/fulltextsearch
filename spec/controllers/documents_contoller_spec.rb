require 'spec_helper'

describe DocumentsController do
  describe '#create' do
    it 'should create new document' do
      expect do
        post :create, document: { content: 'this is a text for test'}
      end.to change(Document, :count).by(1)
    end

    it 'should create tokens records' do
      expect do
      	post :create, document: { content: 'this is a text for test'}
      end.to change(Token, :count).by(6)
    end
  end

  describe '#search' do
  	context 'when there does not exist documents' do
      it 'should return empty array' do
      	post :search, query: 'machine'
      	expect(assigns(:documents)).to be_empty
      end
  	end

  	context 'when query match with some token' do
  	  let(:content) { 'this is a full text search rails app' }
      before do
      	document = Document.new(content: content)
      	document.save
      end

      it 'should return document' do
        post :search, query: 'rails'
        documents = assigns(:documents)
        expect(documents.size).to eq(1)
        expect(documents.first.content).to eq(content)
      end
    end
  end
end