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
