Extension { #name : 'Set' }

{ #category : '*AoC-Base' }
Set >> canonicalKey [
	"Returns a canonical representation of the set for use as a dictionary key."

	^ self asSortedCollection asArray
]
