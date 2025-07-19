Class {
	#name : 'AoCBaseTest',
	#superclass : 'TestCase',
	#instVars : [
		'inst'
	],
	#classVars : [
		'BasePath',
		'Day',
		'MainClass',
		'Year'
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

{ #category : 'utilities' }
AoCBaseTest >> readInputFileAsLines: fileName [

	| fileRef dayName |
	dayName := 'day' , self class day asString.

	fileRef := BasePath asFileReference / dayName / fileName.

	^ fileRef contents lines
]

{ #category : 'running' }
AoCBaseTest >> setUp [

	super setUp.

	inst := MainClass new
]
