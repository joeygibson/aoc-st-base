Class {
	#name : 'AoCBaseTest',
	#superclass : 'TestCase',
	#instVars : [
		'inst',
		'day',
		'path'
	],
	#category : 'AoC-Base',
	#package : 'AoC-Base'
}

{ #category : 'accessing' }
AoCBaseTest >> day [

	^ day
]

{ #category : 'accessing' }
AoCBaseTest >> day: anObject [

	day := anObject
]

{ #category : 'accessing' }
AoCBaseTest >> path [

	^ path
]

{ #category : 'accessing' }
AoCBaseTest >> path: anObject [

	path := anObject
]

{ #category : 'utilities' }
AoCBaseTest >> readInputFileAsLines: fileName for: aDay onPath: aPath [

	| fileRef dayName |
	dayName := 'day' , aDay.

	fileRef := aPath asFileReference / dayName / fileName.

	^ fileRef contents lines
]
