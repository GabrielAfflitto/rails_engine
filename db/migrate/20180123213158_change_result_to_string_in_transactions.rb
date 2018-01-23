class ChangeResultToStringInTransactions < ActiveRecord::Migration[5.1]
  def change
    change_column :transactions, :result, :string

  end
end
