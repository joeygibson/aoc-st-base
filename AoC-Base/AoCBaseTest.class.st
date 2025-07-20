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
AoCBaseTest class >> basePath [
	^ BasePath 
]

{ #category : 'initialization' }
AoCBaseTest class >> basePath: aPath [
	BasePath := aPath.
]

{ #category : 'accessing' }
AoCBaseTest class >> day [

	^ Day
]

{ #category : 'accessing' }
AoCBaseTest class >> day: anObject [

	Day := anObject
]

{ #category : 'accessing' }
AoCBaseTest class >> mainClass [
	^ MainClass.
]

{ #category : 'accessing' }
AoCBaseTest class >> mainClass: mainClass [
	MainClass := mainClass.
]

{ #category : 'accessing' }
AoCBaseTest class >> year [
	^ Year. 
]

{ #category : 'instance creation' }
AoCBaseTest class >> year: aYear [
	Year := aYear.
]

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
