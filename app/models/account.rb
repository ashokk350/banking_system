class Account < ApplicationRecord
	belongs_to :user

	has_many :transactions, dependent: :destroy

	validates :account_number, presence: true
	validates :account_number, uniqueness: true

	def deposit(deposit_amount)
		with_lock do
			updated_amount = amount.to_i + deposit_amount
	  	update(amount: updated_amount)
	  	transaction = transactions.create(amount: deposit_amount, balance: updated_amount, 
	  		transaction_type: Transaction.transaction_types[:deposit])
	  	UserMailer.deliver_email(user, transaction, 'deposited').deliver_now
	  end
	end

	def withdraw(withdraw_amount)
		with_lock do
      updated_amount = amount.to_i - withdraw_amount
      update(amount: updated_amount)
      transaction = transactions.create(amount: withdraw_amount, balance: updated_amount, 
      	transaction_type: Transaction.transaction_types[:withdraw])
      UserMailer.deliver_email(user, transaction, 'debited').deliver_now
	  end
	end
end
