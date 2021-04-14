class CreateQuoteShipmentItems < ActiveRecord::Migration[6.0]
  def change
    create_table :quote_shipment_items do |t|
      t.integer :number_of_item, default: 1

      t.decimal :length
      t.decimal :width
      t.decimal :height
      t.decimal :weight

      t.string :weight_unit, length: 5
      t.string :dimension_unit, length: 5

      t.jsonb :description
      t.boolean :packaging_consultation

      t.timestamps
    end
  end
end
