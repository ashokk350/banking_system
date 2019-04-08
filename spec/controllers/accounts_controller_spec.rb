require 'rails_helper'

RSpec.describe AccountsController, type: :controller do
	before(:all) do
		DatabaseCleaner.clean_with(:truncation, only: %w[users accounts])
  	@user = FactoryGirl.create(:user)
  	@account = FactoryGirl.create(:account, user: @user)
  end

  before :each do
    sign_in @user, scope: :user
  end

  describe '#edit' do
    it 'returns account for edit' do
      get 'edit', params: { id: @user.id}
      expect(response).to render_template('edit')
      expect(response).to have_http_status(:success)
    end
  end

  describe '#show' do
    it 'returns account' do
      get 'show', params: { id: @account.id}
      expect(response).to render_template('show')
      expect(response).to have_http_status(:success)
    end
  end

  describe '#create' do
    it 'deposits amount to account' do
      get 'create', params: { account: { account_number: @account.account_number, amount: 20 } }
      expect(response).to redirect_to(root_path)
    end

    it 'account does not found' do
      get 'create', params: { account: { account_number: '123' } }
      expect(response).to render_template('new')
      expect(response).to have_http_status(:success)
    end
  end

  describe '#update' do
    it 'debits amount from account' do
      get 'update', params: { id: @account.id, amount: 20 }
      expect(response).to redirect_to(root_path)
    end

    it 'debits amount greater than actual amount' do
      get 'update', params: { id: @account.id, amount: 20000000000 }
      expect(response).to render_template('edit')
      expect(response).to have_http_status(:success)
    end
  end
end
