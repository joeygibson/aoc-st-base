Class {
	#name : 'AoCCodeCreator',
	#superclass : 'SpPresenter',
	#instVars : [
		'labelPresenter',
		'buttonPresenter',
		'yearPresenter',
		'yearLabelPresenter',
		'dayPresenter',
		'dayLabelPresenter',
		'pathLabelPresenter',
		'pathPresenter'
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

	| className testClassName |
	className := self classNameForDay.
	testClassName := className , 'Test'.

	self createPackagesIfNecessary.

	self createClasses: className.

	buttonPresenter enabled: false.

	(Smalltalk at: className asSymbol) browse.
	(Smalltalk at: testClassName asSymbol) browse.

	self inform: ('Created {1}, {2}' format: {
				 className.
				 testClassName })
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
AoCCodeCreator >> createClasses: theClassName [

	| packageName testPackageName testClassName year day |
	year := yearPresenter text.
	day := dayPresenter number printPaddedWith: $0 to: 2.
	testClassName := theClassName , 'Test'.
	packageName := 'AoC' , yearPresenter number asString.
	testPackageName := packageName , '-Tests'.

	((AoCBase << theClassName asSymbol)
		 package: packageName;
		 comment: ('Day{1} of Advent of Code {2}.' format: {
						  day.
						  year })) install.

	(AoCBaseTest << testClassName asSymbol package: testPackageName)
		install
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

	| pathContainerPresenter yearContainerPresenter dayContainerPresenter |
	pathContainerPresenter := SpPresenter new.
	pathContainerPresenter layout: (SpBoxLayout newLeftToRight
			 add: pathLabelPresenter withConstraints: [ :c |
					 c
						 height: 25;
						 width: 45 ];
			 add: pathPresenter;
			 yourself).

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
		  add: pathContainerPresenter
		  withConstraints: [ :c | c height: 25 ];
		  add: yearContainerPresenter
		  withConstraints: [ :c | c height: 25 ];
		  add: dayContainerPresenter withConstraints: [ :c | c height: 25 ];
		  add: buttonPresenter withConstraints: [ :c | c height: 30 ];
		  yourself
]

{ #category : 'initialization' }
AoCCodeCreator >> initializePresenters [
	
	pathLabelPresenter := self newLabel.
	pathPresenter := self newTextInput .
	yearLabelPresenter := self newLabel.
	yearPresenter := self newNumberInput.
	dayLabelPresenter := self newLabel.
	dayPresenter := self newNumberInput.
	buttonPresenter := self newButton.
	
	pathLabelPresenter label: 'Path'.
	
	pathPresenter text: FileLocator home fullName, '/Projects/' .
		
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

	dayPresenter whenNumberChangedDo: [ :selection |
		self updateButtonState: selection ].

	buttonPresenter
		label: 'Do It!';
		enabled: self classNameAvailable;
		action: [ self buttonClicked ]
]

{ #category : 'initialization' }
AoCCodeCreator >> initializeWindow: aWindowPresenter [

	super initializeWindow: aWindowPresenter.
	
	aWindowPresenter
		title: 'AoC Code Creator';
		initialExtent: 300 @ 170;
		resizable: false;
		centered
]

{ #category : 'actions' }
AoCCodeCreator >> packageNameForYear [

	^ 'AoC' , yearPresenter number asString
]

{ #category : 'tests' }
AoCCodeCreator >> testPackageNameForYear [

	^ self packageNameForYear , '-Tests'
]

{ #category : 'actions' }
AoCCodeCreator >> updateButtonState: selection [
	
	buttonPresenter enabled: self classNameAvailable
]
