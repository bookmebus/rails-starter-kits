class CreateQuoteAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :quote_addresses do |t|
      t.jsonb :name
      t.decimal :lat
      t.decimal :lon
      t.string :type

      t.timestamps
    end
  end
end
