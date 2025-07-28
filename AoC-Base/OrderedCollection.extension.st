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
OrderedCollection >> rotateFrom: sourceIndex length: length to: destIndex [
	"Rotate elements similar to Common Lisp's rotatef.
    Takes elements starting at sourceIndex with given length and swaps them 
    with elements starting at destIndex.
    
    Example:
    | collection |
    collection := OrderedCollection withAll: #(1 2 3 4 5 6 7 8).
    collection rotateFrom: 2 length: 3 to: 6.
    collection -> OrderedCollection(1 5 6 7 2 3 4 8)"

	| sourceElements destElements sourceEnd destEnd |
	"Validate indices and length"
	(sourceIndex < 1 or: [ destIndex < 1 or: [ length < 1 ] ]) ifTrue: [
		^ self error: 'Invalid index or length' ].

	sourceEnd := sourceIndex + length - 1.
	destEnd := destIndex + length - 1.

	(sourceEnd > self size or: [ destEnd > self size ]) ifTrue: [
		^ self error: 'Index out of bounds' ].

	"Don't do anything if source and dest ranges are the same"
	sourceIndex = destIndex ifTrue: [ ^ self ].

	"Extract elements from both ranges"
	sourceElements := Array new: length.
	destElements := Array new: length.

	1 to: length do: [ :i |
			sourceElements at: i put: (self at: sourceIndex + i - 1).
			destElements at: i put: (self at: destIndex + i - 1) ].

	"Swap the ranges"
	1 to: length do: [ :i |
			self at: sourceIndex + i - 1 put: (destElements at: i).
			self at: destIndex + i - 1 put: (sourceElements at: i) ].

	^ self
]

{ #category : '*AoC-Base' }
OrderedCollection >> swapIndex: srcIndex withIndex: dstIndex [

	| tmp |
	tmp := self at: dstIndex.
	self at: dstIndex put: (self at: srcIndex).
	self at: srcIndex put: tmp
]
