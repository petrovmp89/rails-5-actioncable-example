require 'rails_helper'

RSpec.describe NewsController, type: :controller do
  describe "GET index" do
    it "renders the index template" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET new" do
    it "renders the new template" do
      get :new
      expect(response).to be_success
    end
  end
end
