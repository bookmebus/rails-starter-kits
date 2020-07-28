class TranslatableRecord< ApplicationRecord
  include Translateable
  self.abstract_class = true
end
