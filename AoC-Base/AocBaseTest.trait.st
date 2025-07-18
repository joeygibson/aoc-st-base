Trait {
	#name : 'AocBaseTest',
	#category : 'AoC-Base',
	#package : 'AoC-Base'
}

{ #category : 'as yet unclassified' }
AocBaseTest >> readInputFileAsLines: fileName [

	| lines fileRef aocYear matcher|
	
	matcher := self class packageName regex: '\d{4}'.
	
	aocYear := matcher first.	
	
	fileRef := FileLocator home / 'Projects' / 'adventofcode2024'
	           / 'day01' / 'input1.txt'.
	lines := fileRef contents lines
]
