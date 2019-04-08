class AccountsController < ApplicationController
  def show
    @account = Account.includes(:transactions).find(params[:id])
  end

  def new
  end

  def edit 
    @account = Account.find_by(user_id: params[:id])
  end

  def create #deposit
    account = Account.find_by(account_number: params[:account][:account_number])
    if account
      account.deposit(params[:account][:amount].to_i)
      redirect_to root_path
    else
      flash[:error] = "Account Number does not exist."
      render :new
    end
  end

  def update #withdraw
    @account = current_user.account
    if @account.amount >= params[:amount].to_i
      @account.withdraw(params[:amount].to_i)
      redirect_to root_path
    else
      flash[:error] = "Deposit amount is greater than total amount"
      render :edit
    end
  end
end
