Extension { #name : 'Point' }

{ #category : '*AoC-Base' }
Point >> isWithinWidth: width height: height [

	^ self x >= 0 and: [
		  self x < width and: [ self y >= 0 and: [ self y < height ] ] ]
]
