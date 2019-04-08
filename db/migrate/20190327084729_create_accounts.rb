class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.references :user
      t.string :account_number
      t.decimal :amount

      t.timestamps
    end
  end
end
