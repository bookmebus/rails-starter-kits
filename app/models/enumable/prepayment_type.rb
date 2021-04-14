module Enumable
  class PrepaymentType
    UNSPECIFIED = 0

    # The user has to pay this service at the booking time.
    REQUIRED = 1

    # The user can choose to pre-pay this service at the booking time or later,
    # but it is not required in order to book.
    OPTIONAL = 2


    # The prepayment is not supported for this service.
    NOT_SUPPORTED = 3;
  end
end