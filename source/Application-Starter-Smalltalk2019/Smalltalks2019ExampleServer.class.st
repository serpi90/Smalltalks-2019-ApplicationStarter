Class {
	#name : #Smalltalks2019ExampleServer,
	#superclass : #Object,
	#instVars : [
		'server',
		'debugMode'
	],
	#category : #'Application-Starter-Smalltalk2019'
}

{ #category : #'instance creation' }
Smalltalks2019ExampleServer class >> deployedOn: aPort mimeType: aMimeType debugEnabled: aBoolean [

	^ self new initializeDeployedOn: aPort mimeType: aMimeType debugEnabled: aBoolean
]

{ #category : #processing }
Smalltalks2019ExampleServer >> handleError: aSignal [

	^ debugMode
		ifTrue: [ aSignal pass ]
		ifFalse: [ Smalltalks2019CommandLineHandler dumpStackAndReport: aSignal.
			aSignal return: ( ZnResponse serverError: aSignal messageText )
			]
]

{ #category : #initialization }
Smalltalks2019ExampleServer >> initializeDeployedOn: aPort mimeType: aMimeType debugEnabled: aBoolean [

	debugMode := aBoolean.
	server := Teapot configure: ( Dictionary with: #port -> aPort with: #debugMode -> debugMode ).
	server
		exception: Error -> [ :signal | self handleError: signal ];
		GET: '/factorial/<n>' -> [ :request | ( request at: #n ) asNumber factorial ];
		output: ( TeaOutput stringWithContentType: aMimeType )
]

{ #category : #initialization }
Smalltalks2019ExampleServer >> start [

	server start
]
