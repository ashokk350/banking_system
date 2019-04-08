class Transaction < ApplicationRecord
  belongs_to :account

  enum transaction_type: { deposit: 'Deposit', withdraw: 'Withdraw' }

  def self.header_format(sheet)
  	h_format = sheet.add_format
		h_format.set_bold
		h_format.set_color('green')
		h_format.set_align('center')
		h_format
  end

  def self.row_format(sheet)
  	r_format = sheet.add_format
		r_format.set_color('Black')
		r_format.set_align('center')
		r_format
  end

  def self.generate_transaction_history(user_ids, from, to)
  	path = Rails.root.join('tmp', "transaction_history.xlsx").to_path
    file = File.new(path, "w")
  	accounts = Account.where(user_id: user_ids).includes(:user, :transactions)

  	workbook = WriteXLSX.new(file)
  	worksheet = workbook.add_worksheet
  	h_format = Transaction.header_format(workbook)
  	r_format = Transaction.row_format(workbook)

		row = 1
  	accounts.each do |account|
  		transactions = if from.present? && to.present?
  			account.transactions.where(created_at: from..to)
  		else
  			account.transactions
  		end

  		if transactions.present?
	  		worksheet.merge_range("A#{row}:C#{row + 1}", "Name - #{account.user.user_name}", h_format)
	  		worksheet.merge_range("D#{row}:G#{row + 1}", "Acc. No. - #{account.account_number}", h_format)
	  		row += 2

	  		worksheet.merge_range("A#{row}:C#{row + 1}", 'Date', h_format)
	  		worksheet.merge_range("D#{row}:D#{row + 1}", 'Amount', h_format)
	  		worksheet.merge_range("E#{row}:F#{row + 1}", 'Transaction Type', h_format) 
	  		worksheet.merge_range("G#{row}:G#{row + 1}", 'Balance', h_format)
	  		row += 1

	  		transactions.each_with_index do |transaction, j|
	  			row += 1
	  			worksheet.merge_range("A#{row}:C#{row}", transaction.created_at.strftime("%b %d, %Y"), r_format)
	  			worksheet.write(row - 1, 3, transaction.amount)
	  			worksheet.merge_range("E#{row}:F#{row}", transaction.transaction_type, r_format)				
					worksheet.write(row - 1, 6, transaction.balance)
				end
			end

			row += 1
		end
		workbook.close

		path
  end
end
