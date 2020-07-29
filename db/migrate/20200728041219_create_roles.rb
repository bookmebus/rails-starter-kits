class CreateRoles < ActiveRecord::Migration[6.0]
  def change
    create_table :roles do |t|
      t.jsonb :name
      t.jsonb :description
      t.jsonb :access, default: {}
      t.boolean :active, default: true
      t.integer :role_type, default: 0, index: true

      t.timestamps
    end
  end
end
