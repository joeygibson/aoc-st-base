Extension { #name : 'Collection' }

{ #category : '*AoC-Base' }
Collection >> dropWhile: aBlock [

	| result dropping |
	result := OrderedCollection new.
	dropping := true.
	self do: [ :each |
			(dropping and: [ aBlock value: each ]) ifFalse: [
					dropping := false.
					result add: each ] ].
	^ result
]

{ #category : '*AoC-Base' }
Collection >> takeWhile: aBlock [
    | result |
    result := OrderedCollection new.
    self do: [ :each |
        (aBlock value: each)
            ifTrue: [ result add: each ]
            ifFalse: [ ^ result ] ].
    ^ result
]
