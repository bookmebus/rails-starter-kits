module Enumable
  class ServiceType
    UNKNOWN = 0
    DINING_RESERVATION = 1

    # Service that provides food ordering in general, could be either takeout or delivery or both
    FOOD_ORDERING = 2
    FOOD_DELIVERY = 6
    FOOD_TAKEOUT  = 7

    # Services that provide event based ticketing (e.g. concerts, sporting, events, shows)
    EVENT_TICKET = 3
    TRIP_TOUR = 4

    # Service that provides appointments or classes. Recommended for (1) health and fitness, (2) spa and beauty, and (3) financial consults and
    # evaluations services
    APPOINTMENT = 5

    # Service that provides appointment for an online class or session which will be fully virtual. Must be set if enabling virtual service bookings.
    ONLINE_APPOINTMENT = 9

    # Service that allows users to shop from the given merchant. It could either be delivery or pickup.
    SERVICE_TYPE_SHOPPING = 9

  end
end