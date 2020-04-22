require 'rails_helper'

RSpec.describe 'StaticPages', type: :request do
  let(:base_title){ 'Ruby on Rails Tutorial Sample App' }
  
  describe "home" do
    before { get root_path }
    it "レスポンス" do
      expect(response).to have_http_status(200)
    end
    it "タイトル" do
      expect(response.body).to match(/<title>#{base_title}<\/title>/i)
    end
  end
  
  describe "help" do
    before { get help_path }
    it "レスポンス" do
      expect(response).to have_http_status(200)
    end
    it "タイトル" do
      expect(response.body).to match(/<title>Help | #{base_title}<\/title>/i)
    end
  end  
  
  describe "about" do
    before { get about_path }
    it "レスポンス" do
      expect(response).to have_http_status(200)
    end
    it "タイトル" do
      expect(response.body).to match(/<title>About | #{base_title}<\/title>/i)
    end
  end  

  describe "contact" do
    before { get contact_path }
    it "レスポンス" do
      expect(response).to have_http_status(200)
    end
    it "タイトル" do
      expect(response.body).to match(/<title>Contact | #{base_title}<\/title>/i)
    end
  end  
end