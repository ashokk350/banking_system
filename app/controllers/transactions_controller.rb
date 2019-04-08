class TransactionsController < ApplicationController
  def create
  	path = Transaction.generate_transaction_history(params[:user_ids], params[:from], params[:to])
  	send_file path
  end
end
