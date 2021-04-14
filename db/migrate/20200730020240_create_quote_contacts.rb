class CreateQuoteContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :quote_contacts do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :title, length: 4

      t.timestamps
    end
  end
end
