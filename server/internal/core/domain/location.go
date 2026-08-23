package domain

import "math"

type Location struct {
	Latitude  float64
	Longitude float64
	Timestamp int64
}

type DriverLocation struct {
	DriverID string
	Location Location
}

// Haversine formula to compute distance between two points on the sphere.
func (l Location) DistanceTo(target Location) float64 {
	const earthRadiusMeters = 6371000

	lat1 := l.Latitude * math.Pi / 180
	lon1 := l.Longitude * math.Pi / 180
	lat2 := target.Latitude * math.Pi / 180
	lon2 := target.Longitude * math.Pi / 180

	dLat := lat2 - lat1
	dLon := lon2 - lon1

	a := math.Sin(dLat/2)*math.Sin(dLat/2) +
		math.Cos(lat1)*math.Cos(lat2)*
			math.Sin(dLon/2)*math.Sin(dLon/2)
	
	c := 2 * math.Atan2(math.Sqrt(a), math.Sqrt(1-a))

	return earthRadiusMeters * c
}

// IsInsideRadius returns true if the current location is within the specified radius in meters of the target location.
func (l Location) IsInsideRadius(target Location, radiusMeters float64) bool {
	return l.DistanceTo(target) <= radiusMeters
}
