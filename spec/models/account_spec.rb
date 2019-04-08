require 'rails_helper'

RSpec.describe Account, type: :model do
  it { should belong_to(:user) }

  it { should have_many(:transactions) }

  it { should validate_presence_of(:account_number) }
  it { should validate_uniqueness_of(:account_number).case_insensitive }

  before(:all) do
  	DatabaseCleaner.clean_with(:truncation, only: %w[users accounts transactions])
  	@user = FactoryGirl.create(:user)
  	@account = FactoryGirl.create(:account)
  	@transaction = FactoryGirl.create(:transaction)
  end

  describe '#deposit' do
    it 'deposits amount to account' do
      expect(@account.deposit(20)).not_to eq(nil)
    end
  end

  describe '#withdraw' do
    it 'debits amount from account' do
      expect(@account.withdraw(20)).not_to eq(nil)
    end
  end
end
