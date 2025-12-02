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

{ #category : 'adding' }
AoCCodeCreator >> addSetupMethodToClass: testClass forDay: day andYear: year instClassName: theClassName [

	| setUpSource |
	"Now add the setUp method to the test class"
	setUpSource := String streamContents: [ :s |
			               s nextPutAll: 'setUp
	super setUp.
	self day: ''' , day , '''.
	self path: FileLocator home / ''Projects'' / ''adventofcode' , year
				               , ''' asString.

	inst := ' , theClassName , ' new.' ].

	testClass compile: setUpSource classified: 'setup'
]

{ #category : 'adding' }
AoCCodeCreator >> addTestMethodToClass: testClass forPart: part forFile: whichFile [

	| testSource name fileName |
	name := whichFile = #sample
		        ifTrue: [ 'Sample' ]
		        ifFalse: [ 'RealData' ].
	fileName := whichFile = #sample
		            ifTrue: [ 'input0.txt' ]
		            ifFalse: [ 'input1.txt' ].

	testSource := String streamContents: [ :s |
			              s nextPutAll:
				              'testPart' , part asString , 'With' , name , '
|lines res|

	lines := self
		         readInputFileAsLines: ''' , fileName , '''
		         for: self day
		         onPath: self path.

	res := inst part' , part asString , ': lines.

	self assert: res equals: 0.
		' ].
	testClass compile: testSource classified: 'executing'
]

{ #category : 'actions' }
AoCCodeCreator >> buttonClicked [

	| className testClassName |
	className := self classNameForDay.
	testClassName := className , 'Test'.

	self createPackagesIfNecessary.

	self createClasses: className.

	buttonPresenter enabled: false.

	self createDirectoryIfNecessary.

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

	| packageName testPackageName testClassName year day testClass builder |
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

	builder := AoCBaseTest << testClassName asSymbol package:
		           testPackageName.
	testClass := builder install.

	self
		addSetupMethodToClass: testClass
		forDay: day
		andYear: year
		instClassName: theClassName.
	self addTestMethodToClass: testClass forPart: 1 forFile: #sample.
	self addTestMethodToClass: testClass forPart: 1 forFile: #real.
	self addTestMethodToClass: testClass forPart: 2 forFile: #sample.
	self addTestMethodToClass: testClass forPart: 2 forFile: #real
]

{ #category : 'execution' }
AoCCodeCreator >> createDirectoryIfNecessary [

	| dirName dir year day |
	year := yearPresenter text.
	day := dayPresenter number printPaddedWith: $0 to: 2.

	dirName := FileLocator home / 'Projects' / ('adventofcode' , year)
	           / ('day', day).

	dir := dirName asFileReference.
	
	dir ensureCreateDirectory
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
