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

{ #category : 'utilities' }
AoCBaseTest >> increaseTimeout: secs [

	self timeLimit: (Duration seconds: secs)
]

{ #category : 'accessing' }
AoCBaseTest >> path [

	^ path
]

{ #category : 'accessing' }
AoCBaseTest >> path: anObject [

	path := anObject
]

{ #category : 'as yet unclassified' }
AoCBaseTest >> readInputFile: fileName for: aDay onPath: aPath [

	| fileRef dayName |
	dayName := 'day' , aDay.

	fileRef := aPath asFileReference / dayName / fileName.

	^ fileRef contents
]

{ #category : 'utilities' }
AoCBaseTest >> readInputFileAsLines: fileName for: aDay onPath: aPath [

	| fileRef dayName allLines |
	dayName := 'day' , aDay.

	fileRef := aPath asFileReference / dayName / fileName.

	allLines := fileRef contents lines.
	
	[ allLines isNotEmpty and: [ allLines last isEmpty ] ] whileTrue: [
		allLines := allLines allButLast ].
	
	^ allLines
]

{ #category : 'as yet unclassified' }
AoCBaseTest >> readInputFileAsSections: fileName for: aDay onPath: aPath [

	| fileRef dayName contents res |
	dayName := 'day' , aDay.

	fileRef := aPath asFileReference / dayName / fileName.

	contents := fileRef contents.

	res := contents splitOn: String lf , String lf.
	
	^ res
]
