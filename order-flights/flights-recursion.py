def next_leg(flights, source):
    """Find and append next flight to trip"""
    for leg in flights:
        if leg[0] == source:
            trip.append(leg)
            source = leg[1]
            flights.remove(leg)
            next_leg(flights, source)

def previous_leg(flights, destination):
    """Find and prepend previous flight to trip"""
    for leg in flights:
        if leg[1] == destination:
            trip.insert(0, leg)
            destination = leg[0]
            flights.remove(leg)
            previous_leg(flights, destination)

flights = [ 
    ['Minneapolis', 'Las Vegas'],
    ['LA', 'Chicago'],
    ['Las Vegas', 'Seattle'],
    ['Chicago', 'Atlanta'],
    ['Atlanta', 'NY'],
    ['NY', 'Minneapolis'],
]

trip = [flights[0]]
flights.pop(0)

next_leg(flights, trip[0][1])
previous_leg(flights, trip[0][0])
print(trip)
