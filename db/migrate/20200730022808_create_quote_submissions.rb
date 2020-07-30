class CreateQuoteSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :quote_submissions do |t|

      # t.references :pickup_address, null: false, foreign_key: { to_table: :quote_addresses }
      # t.references :delivery_address, null: false, foreign_key: { to_table: :quote_addresses }
      # t.references :contact, null: false, foreign_key: { to_table: :quote_contacts }
      t.integer :shipment_items_count, default: 0
      t.integer :status, default: 0

      t.timestamps
    end

  #   add_reference :quote_submissions, :pickup_address, null: false, foreign_key: { to_table: :quote_addresses }
  #   add_reference :quote_submissions, :delivery_address, null: false, foreign_key: { to_table: :quote_addresses }
  #   add_reference :quote_submissions, :quote_contact, null: false, foreign_key: true

  end
end
