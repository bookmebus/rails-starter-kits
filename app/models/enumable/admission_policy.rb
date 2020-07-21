module Enumable
  class AdmissionPolicy

    # Unused.
    UNSPECIFIED = 0

    # Customers are required to be present at the start time of the
    # availability slot, and the service is expected to finish at the
    # end time of the slot.
    # Examples of TIME_STRICT use cases:
    #   * A tour that starts at 9am that requires all attendees to arrive
    #     at the start time, and returns at around 12pm.
    #   * A haircut reservation at 3pm on Saturday that will take approximately
    #   30 minutes.
    #   * A fitness class from 6pm to 8pm.
    TIME_STRICT = 1

    # Customers can arrive at any time between the start and end time of the
    # availability slot to use this booking.
    #
    # Examples of TIME_FLEXIBLE use cases:
    #   * A museum ticket that can be used during any time on the purchase date.
    #   * An afternoon admission to an amusement park that can be used from
    #  12pm to 9pm.
    TIME_FLEXIBLE = 2;


    # Customers need to arrive at the merchant at the start time of the availability slot but can leave any time they want.
    # For example, in the museum admission scenario, a timed entry ticket for 10am requires the user to be at the museum at 10am.
    # The start time of  availability slots for this service represents the designated entry time.
    # The end time, however, is used solely as a key to identify the
    # availability slot for booking.
    TIMED_ENTRY_WITH_FLEXIBLE_DURATION = 3;
  end
end