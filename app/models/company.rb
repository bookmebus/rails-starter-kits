class Company < TranslatableRecord
  translateable :name, :meta_description, :about

  validates :name, presence: true
  validates :meta_description, presence: true
  validates :about, presence: true
end
