require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
	before(:all) do
		DatabaseCleaner.clean_with(:truncation, only: %w[users accounts])
  	@user = FactoryGirl.create(:user)
  	@account = FactoryGirl.create(:account, user: @user)
  	@transaction = FactoryGirl.create(:transaction, account: @account)
  end

  before :each do
    sign_in @user, scope: :user
  end

  describe '#create' do
    it 'generates transaction history excel sheet' do
      post 'create', params: { user_ids: [@user.id], from: '2019-04-07', to: '2019-04-09' }
      expect(response).to have_http_status(:success)
    end
  end
end
