Class {
	#name : #Smalltalks2019ExampleServer,
	#superclass : #Object,
	#instVars : [
		'server',
		'debugMode',
		'trimPolicy',
		'capitalizationPolicy'
	],
	#category : #'Application-Starter-Smalltalk2019'
}

{ #category : #'instance creation' }
Smalltalks2019ExampleServer class >> deployedOn: aPort changingCaseWith: aCapitalizationPolicy trimBlanks: aBoolean debugMode: isDebugMode [

	^ self new
		initializeDeployedOn: aPort
		changingCaseWith: aCapitalizationPolicy
		trimBlanks: aBoolean
		debugMode: isDebugMode
]

{ #category : #processing }
Smalltalks2019ExampleServer >> echo: aRequest [

	^ capitalizationPolicy value: ( trimPolicy value: aRequest contents  )
]

{ #category : #processing }
Smalltalks2019ExampleServer >> factorial: aRequest [

	^ ( aRequest at: #n ) asNumber factorial
]

{ #category : #processing }
Smalltalks2019ExampleServer >> handleError: aSignal [

	debugMode
		ifTrue: [ aSignal pass ]
		ifFalse: [ Smalltalks2019CommandLineHandler dumpStackAndReport: aSignal ].
	^ TeaResponse serverError
]

{ #category : #initialization }
Smalltalks2019ExampleServer >> initializeDeployedOn: aPort changingCaseWith: aCapitalizationPolicy trimBlanks: aBoolean debugMode: isDebugMode [

	trimPolicy := aBoolean
		ifTrue: [ #trimBoth ]
		ifFalse: [ #yourself ].
	capitalizationPolicy := aCapitalizationPolicy.
	debugMode := isDebugMode.
	server := Teapot configure: ( Dictionary with: #port -> aPort with: #debugMode -> debugMode ).
	server
		exception: Error -> ( Send message: #handleError: to: self );
		GET: '/factorial/<n>' -> ( Send message: #factorial: to: self );
		POST: '/echo' -> ( Send message: #echo: to: self )
]

{ #category : #initialization }
Smalltalks2019ExampleServer >> start [

	server start
]
