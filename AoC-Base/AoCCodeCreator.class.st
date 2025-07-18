Class {
	#name : 'AoCCodeCreator',
	#superclass : 'SpPresenter',
	#instVars : [
		'labelPresenter',
		'buttonPresenter',
		'yearPresenter',
		'yearLabelPresenter',
		'dayPresenter',
		'dayLabelPresenter'
	],
	#category : 'AoC-Base',
	#package : 'AoC-Base'
}

{ #category : 'instance creation' }
AoCCodeCreator class >> open [

	^ self new open
]

{ #category : 'actions' }
AoCCodeCreator >> buttonClicked [

	| className |
	className := self classNameForDay.

	self createPackagesIfNecessary.

	self createClasses: className.

	buttonPresenter enabled: false.

	(Smalltalk at: className asSymbol) browse.

	self inform: 'Created class ' , className
]

{ #category : 'execution' }
AoCCodeCreator >> classNameAvailable [

	^ (Smalltalk hasClassNamed: self classNameForDay) not
]

{ #category : 'execution' }
AoCCodeCreator >> classNameForDay [

	| paddedDay |
	paddedDay := dayPresenter number printPaddedWith: $0 to: 2.
	^ 'AoCDay' , paddedDay
]

{ #category : 'execution' }
AoCCodeCreator >> createClasses: aString [

	| packageName testPackageName |
	packageName := 'AoC' , yearPresenter number asString.
	testPackageName := packageName , '-Tests'.

	((Object << aString asSymbol)
		 slots: {  };
		 package: packageName) install.

	((TestCase << (aString , 'Test') asSymbol)
		 slots: {  };
		 package: testPackageName) install
]

{ #category : 'execution' }
AoCCodeCreator >> createPackagesIfNecessary [

	| packageName testPackageName |
	packageName := self packageNameForYear.
	testPackageName := self testPackageNameForYear.

	(SystemOrganization packageOrganizer packageNames includes:
		 packageName) ifFalse: [ SystemOrganization addPackage: packageName ].

	(SystemOrganization packageOrganizer packageNames includes:
		 testPackageName) ifFalse: [
		SystemOrganization addPackage: testPackageName ]
]

{ #category : 'layout' }
AoCCodeCreator >> defaultLayout [

	| yearContainerPresenter dayContainerPresenter |
	yearContainerPresenter := SpPresenter new.
	yearContainerPresenter layout: (SpBoxLayout newLeftToRight
			 add: yearLabelPresenter withConstraints: [ :c |
					 c
						 height: 25;
						 width: 45 ];
			 add: yearPresenter;
			 yourself).

	dayContainerPresenter := SpPresenter new.
	dayContainerPresenter layout: (SpBoxLayout newLeftToRight
			 add: dayLabelPresenter withConstraints: [ :c |
					 c
						 height: 25;
						 width: 45 ];
			 add: dayPresenter;
			 yourself).

	^ SpBoxLayout newVertical
		  spacing: 10;
		  add: yearContainerPresenter
		  withConstraints: [ :c | c height: 25 ];
		  add: dayContainerPresenter withConstraints: [ :c | c height: 25 ];
		  add: buttonPresenter withConstraints: [ :c | c height: 30 ];
		  yourself
]

{ #category : 'initialization' }
AoCCodeCreator >> initializePresenters [

	yearLabelPresenter := self newLabel.
	yearPresenter := self newNumberInput.
	dayLabelPresenter := self newLabel.
	dayPresenter := self newNumberInput.
	buttonPresenter := self newButton.
		
	yearLabelPresenter label: 'Year'.
	
	yearPresenter 
		minimum: 2000;
		maximum: 2050;
		number: Date today year;
		climbRate: 1;
		digits: 0.
		
	dayLabelPresenter label: 'Day'.
	
	dayPresenter
		minimum: 1;
		maximum: 25;
		number: Date today dayOfMonth ;
		climbRate: 1;
		digits: 0.

	dayPresenter whenSelectionChangedDo: [ :selection |
		self updateButtonState: selection ].

	buttonPresenter
		label: 'Do It!';
		enabled: self classNameAvailable;
		action: [ self buttonClicked ]
]

{ #category : 'initialization' }
AoCCodeCreator >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'AoC Code Creator';
		initialExtent: 300 @ 135;
		resizable: false;
		centered
]

{ #category : 'as yet unclassified' }
AoCCodeCreator >> packageNameForYear [

	^ 'AoC' , yearPresenter number asString
]

{ #category : 'tests' }
AoCCodeCreator >> testPackageNameForYear [
	^ self packageNameForYear, '-Tests'.
]

{ #category : 'actions' }
AoCCodeCreator >> updateButtonState: selection [
	buttonPresenter enabled: self classNameAvailable
]
