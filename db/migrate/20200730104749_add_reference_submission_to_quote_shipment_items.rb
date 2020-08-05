class AddReferenceSubmissionToQuoteShipmentItems < ActiveRecord::Migration[6.0]
  def change
    add_reference :quote_shipment_items, :submission, null: false, foreign_key: { to_table: :quote_submissions }
  end
end
