require 'rails_helper'

RSpec.describe Tenant, type: :model do
  it 'sets tenant_key in a parameterized value' do
    tenant = create(:tenant, tenant_key: 'Online Site')
    expect(tenant.tenant_key).to eq 'online-site'
  end

  it 'requires name to be set' do
    tenant = build(:tenant,  name: {})
    result = tenant.valid?

    expect(result).to eq false
    expect(tenant.errors.full_messages).to eq ["Name can't be blank"]
  end

  it 'requires tenant_key to be set' do
    tenant = build(:tenant,  tenant_key: nil)
    result = tenant.valid?

    expect(result).to eq false
    expect(tenant.errors.full_messages).to eq ["Tenant key can't be blank"]
  end

end
