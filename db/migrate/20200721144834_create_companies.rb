class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.jsonb :name
      t.jsonb :meta_description
      t.jsonb :about

      t.timestamps
    end
  end
end
