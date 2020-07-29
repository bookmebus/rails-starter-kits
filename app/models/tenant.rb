class Tenant < TranslatableRecord
  translateable :name

  validates :name, presence: true
  validates :tenant_key, presence: true
  validates :tenant_key, uniqueness: true

  before_save :parameterize_attributes

  after_create :create_tenant_schema
  after_destroy :drop_tenat_schema

  def self.ensure_bmb_tenant
    bmb_tenant = Tenant.where(tenant_key: 'bmb').first_or_initialize
    if bmb_tenant.new_record?
      bmb_tenant.name = { en: 'Bmb'}
      bmb_tenant.save
    end
    bmb_tenant
  end

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
