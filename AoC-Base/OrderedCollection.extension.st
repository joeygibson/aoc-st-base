Extension { #name : 'OrderedCollection' }

{ #category : '*AoC-Base' }
OrderedCollection >> position: aBlock [

	| index |
	index := 0.

	self doWithIndex: [ :item :i |
			(aBlock value: item) ifTrue: [
					index := i.
					^ index ] ].

	^ 0
]

{ #category : '*AoC-Base' }
OrderedCollection >> swapIndex: srcIndex withIndex: dstIndex [

	| tmp |
	tmp := self at: dstIndex.
	self at: dstIndex put: (self at: srcIndex).
	self at: srcIndex put: tmp
]
