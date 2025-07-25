Extension { #name : 'Array' }

{ #category : '*AoC-Base' }
Array >> cartesianProductOfLength: n [

	n = 1
		ifTrue: [ ^ self collect: [ :e | { e } ] ]
		ifFalse: [
				^ self flatCollect: [ :e |
						  (self cartesianProductOfLength: n - 1) collect: [ :tail |
							  { e } , tail ] ] ]
]
