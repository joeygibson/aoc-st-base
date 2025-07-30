Class {
	#name : 'AoCBase',
	#superclass : 'Object',
	#category : 'AoC-Base',
	#package : 'AoC-Base'
}

{ #category : 'parsing' }
AoCBase >> parseToDictGrid: lines withConverter: aBlock [

	| map height width |
	height := lines size.
	width := lines first size.

	map := Dictionary new.

	lines doWithIndex: [ :row :r |
		row doWithIndex: [ :col :c | map at: c @ r put: (aBlock value: col) ] ].

	^ map
]

{ #category : 'parsing' }
AoCBase >> parseToDictGridAsIntegers: lines [

	^ self
		  parseToDictGrid: lines
		  withConverter: [ :v | v asString asInteger ]
]

{ #category : 'parsing' }
AoCBase >> parseToDictGridAsStrings: lines [

	^ self parseToDictGrid: lines withConverter: #asString
]

{ #category : 'parsing' }
AoCBase >> parseToGrid: lines withConverter: aBlock [

	| map height width |
	height := lines size.
	width := lines first size.

	map := CTNewArray2D width: width height: height.

	lines doWithIndex: [ :row :r |
			row doWithIndex: [ :col :c |
				map atColumn: c atRow: r put: (aBlock value: col) ] ].

	^ map
]

{ #category : 'parsing' }
AoCBase >> parseToGridAsIntegers: lines [

	^ self
		  parseToGrid: lines
		  withConverter: [ :v | v asString asInteger ]
]

{ #category : 'parsing' }
AoCBase >> parseToGridAsStrings: lines [

	^ self parseToGrid: lines withConverter: #asString.
]
