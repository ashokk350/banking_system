FactoryGirl.define do
  factory :transaction do
    account_id 1
    amount '200'
    balance '4000'
    transaction_type 'deposit'
  end
end