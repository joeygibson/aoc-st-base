Class {
	#name : 'BaselineOfAoCBase',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfAoC-Base',
	#package : 'BaselineOfAoC-Base'
}

{ #category : 'baselines' }
BaselineOfAoCBase >> baseline: spec [

	<baseline>
	spec
		baseline: 'ContainersArray2D'
		with: [
		spec repository: 'github://pharo-containers/Containers-Array2D/src' ]
]
