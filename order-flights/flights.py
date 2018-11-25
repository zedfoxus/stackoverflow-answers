def source(first_leg, last_leg):
    """Gets the leg that has no predecessor"""
    for leg in first_leg:
        if leg not in last_leg:
            return leg

def destination(first_leg, last_leg):
    """Gets the leg that has no successor"""
    for leg in last_leg:
        if leg not in first_leg:
            return leg

def arrange_flights(flights, source):
    """Arranges flight legs in order. Finds source, moves to trip. Sets the next one in line as the source, moves to trip. Continues"""
    trip = []
    while len(flights) > 0:
        for leg in flights:
            if leg[0] == source:
                source = leg[1]
                trip.append(leg)
                flights.remove(leg)
                break
    
    return trip

flights = [
    ['Minneapolis', 'Las Vegas'],
    ['LA', 'Chicago'],
    ['Las Vegas', 'Seattle'],
    ['Chicago', 'Atlanta'],
    ['Atlanta', 'NY'],
    ['NY', 'Minneapolis'],
]

# Will contain Minneapolis, LA, LV, Chicago, Atlanta, NY
first_leg = [x[0] for x in flights]
# Will contain LV, Chicago, Seattle, Atlanta, NY, Minneapolis
last_leg = [x[1] for x in flights]
# Will be LA
source = source(first_leg, last_leg)
# Will be Seattle
destination = destination(first_leg, last_leg)

trip = arrange_flights(flights, source)
print(trip)
