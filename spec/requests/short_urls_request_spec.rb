require 'rails_helper'

RSpec.describe "ShortUrls", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/short_urls/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/short_urls/show"
      expect(response).to have_http_status(:success)
    end
  end

end
