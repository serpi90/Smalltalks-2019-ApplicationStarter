Class {
	#name : #Smalltalks2019ExampleServer,
	#superclass : #Object,
	#instVars : [
		'server'
	],
	#category : #'Application-Starter-Smalltalk2019'
}

{ #category : #'instance creation' }
Smalltalks2019ExampleServer class >> deployedOn: aPort changingCaseWith: aCapitalizationPolicy trimBlanks: aBoolean [

	^ self new initializeDeployedOn: aPort changingCaseWith: aCapitalizationPolicy trimBlanks: aBoolean
]

{ #category : #initialization }
Smalltalks2019ExampleServer >> initializeDeployedOn: aPort changingCaseWith: aCapitalizationPolicy trimBlanks: aBoolean [

	server := Teapot configure: {( #port -> aPort )}.
	server
		exception:
			Error
				-> [ :signal | 
					Smalltalks2019CommandLineHandler dumpStackAndReport: signal.
					self halt
					];
		GET: '/factorial/<n>' -> [ :req | ( req at: #n ) asNumber factorial ];
		POST:
			'/echo'
				-> [ :req | 
					aCapitalizationPolicy
						value:
							( aBoolean
								ifTrue: [ req body trimBoth ]
								ifFalse: [ req body ] )
					]
]

{ #category : #initialization }
Smalltalks2019ExampleServer >> start [

	server start
]
