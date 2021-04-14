module Enumable
  class EntityType
    UNSPECIFIED = 0

    #The entity represents the artist or group performing at a
    #concert or a show. Only applicable when event category is CONCERT or
    #THEATRE.
    PERFORMER = 1

    #The entity represents the sports team or player at the event. Only
    #applicable when event category is SPORTS.
    PLAYER = 2

    #The entity represents the tour that this event belongs to. Only
    #applicable when event category is CONCERT.
    CONCERT_TOUR = 3

    #The entity represents a sports tournament that this event
    #belongs to. Only applicable when event category is SPORTS.
    SPORTS_SERIES = 4

    #The entity represents the type of play (e.g., musical, comedy, ballet,
    #etc.) performed at the event. Only applicable when event category is
    #THEATRE.
    PLAY = 5

  end

end