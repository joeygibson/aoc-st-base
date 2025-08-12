"
AStarSolver - Generic A* shorted path solver.
"
Class {
	#name : 'AStarSolver',
	#superclass : 'Object',
	#instVars : [
		'map',
		'startPoint',
		'endPoint'
	],
	#category : 'AoC-Base',
	#package : 'AoC-Base'
}

{ #category : 'as yet unclassified' }
AStarSolver class >> withMap: aMap startPoint: start endPoint: end [

	^ self new
		  map: aMap;
		  startPoint: start;
		  endPoint: end
]

{ #category : 'accessing' }
AStarSolver >> endPoint [

	^ endPoint
]

{ #category : 'accessing' }
AStarSolver >> endPoint: anObject [

	endPoint := anObject
]

{ #category : 'executing' }
AStarSolver >> findShortestPath [
	| openSet closedSet cameFrom gScore fScore current neighbors |
	
	openSet := OrderedCollection with: startPoint.
	closedSet := Set new.
	cameFrom := Dictionary new.
	gScore := Dictionary new.
	fScore := Dictionary new.
	
	"Initialize scores"
	gScore at: startPoint put: 0.
	fScore at: startPoint put: (startPoint manhattanDistanceTo: endPoint).
	
	[ openSet isNotEmpty ] whileTrue: [
		"Find node in openSet with lowest fScore"
		current := openSet detectMin: [ :node | 
			fScore at: node ifAbsent: [ Float infinity ] 
		].
		
		"Check if we reached the goal"
		current = endPoint ifTrue: [
			"Reconstruct and return the path"
			^ self reconstructPath: cameFrom from: current
		].
		
		"Move current from open to closed set"
		openSet remove: current.
		closedSet add: current.
		
		"Examine each neighbor"
		neighbors := self neighborsOf: current.
		neighbors do: [ :neighbor |
			"Skip if already evaluated"
			(closedSet includes: neighbor) ifFalse: [
				| tentativeGScore |
				tentativeGScore := (gScore at: current) + 1.
				
				"Add to open set if not already there"
				(openSet includes: neighbor) ifFalse: [
					openSet add: neighbor
				].
				
				"Check if this path is better"
				tentativeGScore < (gScore at: neighbor ifAbsent: [ Float infinity ]) ifTrue: [
					"This path is the best so far, record it"
					cameFrom at: neighbor put: current.
					gScore at: neighbor put: tentativeGScore.
					fScore at: neighbor put: tentativeGScore + (neighbor manhattanDistanceTo: endPoint)
				]
			]
		]
	].
	
	"No path found"
	^ OrderedCollection new
]

{ #category : 'testing' }
AStarSolver >> isWalkable: aPoint [

	| x y |
	x := aPoint x.
	y := aPoint y.

	"Check bounds"
	(x < 1 or: [ x > (map width) ]) ifTrue: [ ^ false ].
	(y < 1 or: [ y > map height ]) ifTrue: [ ^ false ].

	"Check if it's a wall"
	^ (map atColumn: x atRow: y) ~= '#'
]

{ #category : 'accessing' }
AStarSolver >> map [

	^ map
]

{ #category : 'accessing' }
AStarSolver >> map: anObject [

	map := anObject
]

{ #category : 'executing' }
AStarSolver >> neighborsOf: aPoint [

	^ aPoint fourNeighbors select: [ :neighbor |
		  self isWalkable: neighbor ]
]

{ #category : 'executing' }
AStarSolver >> reconstructPath: cameFrom from: current [

	| path cur |
	path := OrderedCollection new.
	cur := current.

	[ cur isNotNil ] whileTrue: [
			path addFirst: cur.
			cur := cameFrom at: cur ifAbsent: [ nil ] ].

	^ path
]

{ #category : 'accessing' }
AStarSolver >> startPoint [

	^ startPoint
]

{ #category : 'accessing' }
AStarSolver >> startPoint: anObject [

	startPoint := anObject
]
