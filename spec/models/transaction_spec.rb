require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it { should belong_to(:account) }

  before(:all) do
  	DatabaseCleaner.clean_with(:truncation, only: %w[users accounts transactions])
  	@user = FactoryGirl.create(:user)
  	@account = FactoryGirl.create(:account)
  	@transaction = FactoryGirl.create(:transaction)
  	@path = Rails.root.join('tmp', "transaction_history.xlsx").to_path
  end

  describe '#generate_transaction_history' do
    it 'generates excel sheet for transaction history with dates' do
      expect(Transaction.generate_transaction_history([@user.id], '2019-04-07', '2019-04-09')).to eq(@path)
    end

    it 'generates excel sheet for transaction history without dates' do
      expect(Transaction.generate_transaction_history([@user.id], '', '')).to eq(@path)
    end
  end
end
