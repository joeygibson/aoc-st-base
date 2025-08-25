Extension { #name : 'Point' }

{ #category : '*AoC-Base' }
Point >> euclideanDistanceTo: anotherPoint [
	"Return the integer Euclidean distance between two points (head and tail)"

	| dx dy squaredDist dist |
	dx := self x - anotherPoint x.
	dy := self y - anotherPoint y.
	squaredDist := dx squared + dy squared.
	dist := squaredDist sqrt.
	^ dist asInteger
]

{ #category : '*AoC-Base' }
Point >> isWithinWidth: width height: height [

	^ self x > 0 and: [
		  self x <= width and: [ self y between: 1 and: height ] ]
]

{ #category : '*AoC-Base' }
Point >> manhattanDistanceTo: anotherPoint [

	^ (self x - anotherPoint x) abs + (self y - anotherPoint y) abs
]

{ #category : '*AoC-Base' }
Point >> pointsOnLineTo: other [
	"Return an OrderedCollection of all integer points between self and other, inclusive, using a Bresenham-like algorithm."

	| points x0 y0 x1 y1 dx dy sx sy err e2 |
	points := OrderedCollection new.
	x0 := self x.
	y0 := self y.
	x1 := other x.
	y1 := other y.
	dx := (x1 - x0) abs.
	dy := (y1 - y0) abs.
	sx := x0 < x1
		      ifTrue: [ 1 ]
		      ifFalse: [
				      x0 > x1
					      ifTrue: [ -1 ]
					      ifFalse: [ 0 ] ].
	sy := y0 < y1
		      ifTrue: [ 1 ]
		      ifFalse: [
				      y0 > y1
					      ifTrue: [ -1 ]
					      ifFalse: [ 0 ] ].
	err := dx - dy.
	[ x0 = x1 and: [ y0 = y1 ] ] whileFalse: [
			points add: x0 @ y0.
			e2 := 2 * err.
			e2 > dy negated ifTrue: [
					err := err - dy.
					x0 := x0 + sx ].
			e2 < dx ifTrue: [
					err := err + dx.
					y0 := y0 + sy ] ].
	points add: x1 @ y1. "add final point"
	^ points
]
