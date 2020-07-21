class Tenant < TranslatableRecord
  translateable :name

  before_save :parameterize_attributes

  after_create :create_tenant_schema
  after_destroy :drop_tenat_schema

  def parameterize_attributes
    self.tenant_key = self.tenant_key.parameterize
  end

  def create_tenant_schema
    Apartment::Tenant.create(self.tenant_key) 
  end

  def drop_tenat_schema
    Apartment::Tenant.drop(self.tenant_key)
  end
end
