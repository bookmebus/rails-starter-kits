module Enumable
  class PriceType
    #The price is for a fixed amount. This is the default value if the field is not set.
    #$50 deposit to reserve a table; $20 no show fee for a yoga class
    FIXED_RATE_DEFAULT = 0

    #The price specified is per person, and the total price is calculated
    #according to the party size specified in Resources as price_micros *
    #party_size. A PER_PERSON price must be accompanied by a party size in the
    #availability resources. If it is not, a party size of one is used.
    #$10 each for tickets to a museum
    PER_PERSON = 1

  end

end