class AddTenantKeyToTenants < ActiveRecord::Migration[6.0]
  def change
    add_column :tenants, :tenant_key, :string
    add_index :tenants, :tenant_key, unique: true, name: 'tenant_key_code'
  end
end
