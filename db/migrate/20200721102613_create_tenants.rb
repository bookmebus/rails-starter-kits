class CreateTenants < ActiveRecord::Migration[6.0]
  def change
    create_table :tenants do |t|
      t.jsonb :name
 
      t.timestamps
    end
  end
end
