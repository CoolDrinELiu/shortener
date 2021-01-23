require 'rails_helper'

RSpec.describe "ShortUrls", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/short_urls"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    let(:short_url) { create(:short_url) }
    before :each do
      stub_request(:any, short_url.target_url).to_return(
        :body => "SUCCESS",
        :status => 200,
        :headers => { 'Content-Length' => 3 }
      )
    end

    it "returns http success" do
      get "/short_urls/#{short_url.url}"
      expect(response).to redirect_to(short_url.target_url)
    end

    it "should add the clicks" do
      expect { get "/short_urls/#{short_url.url}" }.to change { short_url.reload.clicks }.by(1)
    end
  end

  describe "POST /create" do
    let(:params) do
      {short_url: {target_url: 'https://www.google.com'}}.with_indifferent_access
    end

    it "create a record" do
      expect {
        post "/short_urls", params: params
      }.to change { ShortUrl.count }.by(1)
    end
  end

  describe "PUT /enabled and /disabled" do
    let(:short_url) { create(:short_url) }
    it "should activate" do
      put "/short_urls/#{short_url.id}/enabled"
      expect(short_url.active).to be_truthy
    end

    it "should inactivate" do
      put "/short_urls/#{short_url.id}/disabled"
      expect(short_url.reload.active).to be_falsy
    end
  end
end