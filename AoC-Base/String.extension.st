Extension { #name : 'String' }

{ #category : '*AoC-Base' }
String >> extractAllNumbers [

	^ '(\-)?\d+' asRegex matchesIn: self collect: [ :c | c asInteger ]
]
