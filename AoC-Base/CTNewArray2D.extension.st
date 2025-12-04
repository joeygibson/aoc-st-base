Extension { #name : 'CTNewArray2D' }

{ #category : '*AoC-Base' }
CTNewArray2D >> selectKeysForValuesMatching: aBlock [

	| keys |
	keys := OrderedCollection new.

	1 to: self width do: [ :x |
			1 to: self height do: [ :y |
			(aBlock value: (self at: x @ y)) ifTrue: [ keys add: x @ y ] ] ].

	^ keys
]
