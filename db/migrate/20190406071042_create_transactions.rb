class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :account, foreign_key: true
      t.decimal :amount
      t.decimal :balance
      t.string :transaction_type

      t.timestamps
    end
  end
end
