Extension { #name : 'ArrayedCollection' }

{ #category : '*AoC-Base' }
ArrayedCollection >> cartesianProductOfLength: n [

	n = 1
		ifTrue: [ ^ self collect: [ :e | { e } ] ]
		ifFalse: [
				^ self flatCollect: [ :e |
						  (self cartesianProductOfLength: n - 1) collect: [ :tail |
							  { e } , tail ] ] ]
]
