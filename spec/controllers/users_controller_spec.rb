require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	before(:all) do
    DatabaseCleaner.clean_with(:truncation, only: %w[users])
  	@user = FactoryGirl.create(:user)
  end

  before :each do
    sign_in @user, scope: :user
  end

  describe '#index' do
    it 'returns normal users' do
      get 'index'
      expect(response).to render_template('index')
      expect(response).to have_http_status(:success)
    end
  end
end
