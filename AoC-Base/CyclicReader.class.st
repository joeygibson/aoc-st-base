"
A class that wraps a string so you can read from it forever.
"
Class {
	#name : 'CyclicReader',
	#superclass : 'Object',
	#instVars : [
		'collection',
		'index'
	],
	#category : 'AoC-Base',
	#package : 'AoC-Base'
}

{ #category : 'instance creation' }
CyclicReader class >> on: aString [

	^ self new initializeOn: aString
]

{ #category : 'initialization' }
CyclicReader >> initializeOn: aString [

	collection := aString.
	index := 1.

	^ self
]

{ #category : 'accessing' }
CyclicReader >> next [

	| element |
	element := collection at: index.
	index := index \\ collection size + 1.

	^ element
]

{ #category : 'initialization' }
CyclicReader >> reset [

	index := 1
]
