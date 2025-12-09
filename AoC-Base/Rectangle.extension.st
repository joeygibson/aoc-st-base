Extension { #name : 'Rectangle' }

{ #category : '*AoC-Base' }
Rectangle >> inclusiveArea [

	^ self width + 1 * (self height + 1)
]
