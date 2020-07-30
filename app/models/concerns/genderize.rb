module Genderize
  # presentation_f: "Sig.ra %{customer_name}" 
  # presentation_m: "Sig. %{customer_name}"
  def genderize(key)
    "#{key}_#{self.gender}" 
  end

  def gender
    raise "You must define genter method"
    # gender_field_from_database_or_wherever || 'm' 
  end
end 