class AddSubmissionIdToQuoteAddresses < ActiveRecord::Migration[6.0]
  def change
    add_reference :quote_addresses, :submission, null: false, foreign_key: { to_table: :quote_submissions }
  end
end
