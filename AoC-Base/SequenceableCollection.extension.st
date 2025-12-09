Extension { #name : 'SequenceableCollection' }

{ #category : '*AoC-Base' }
SequenceableCollection >> cartesianProductOfLength: n [

	n = 1
		ifTrue: [ ^ self collect: [ :e | { e } ] ]
		ifFalse: [
				^ self flatCollect: [ :e |
						  (self cartesianProductOfLength: n - 1) collect: [ :tail |
							  { e } , tail ] ] ]
]

{ #category : '*AoC-Base' }
SequenceableCollection >> uniquePairs [

	| pairs |
	pairs := OrderedCollection new.
	1 to: self size do: [ :i |
			i + 1 to: self size do: [ :j |
					pairs add: {
							(self at: i).
							(self at: j) } ] ].
	^ pairs
]
