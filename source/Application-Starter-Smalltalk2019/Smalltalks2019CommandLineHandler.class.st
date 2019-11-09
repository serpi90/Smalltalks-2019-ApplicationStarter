Class {
	#name : #Smalltalks2019CommandLineHandler,
	#superclass : #ApplicationStarterCommandLineHandler,
	#category : #'Application-Starter-Smalltalk2019'
}

{ #category : #accessing }
Smalltalks2019CommandLineHandler class >> commandName [

	^ 'smalltalks2019'
]

{ #category : #accessing }
Smalltalks2019CommandLineHandler class >> description [

	^ 'Example Command line handler for Smalltalks 2019, HI!'
]

{ #category : #'private - accessing' }
Smalltalks2019CommandLineHandler class >> logPrefix [

	^ 'factorial'
]

{ #category : #'private - activation' }
Smalltalks2019CommandLineHandler >> basicActivate [

	| port format |

	port := self configuration at: 'port'.
	format := self configuration at: 'format'.
	( Smalltalks2019ExampleServer
		deployedOn: port
		mimeType: format
		debugEnabled: self isDebugModeEnabled ) start
]

{ #category : #'private - accessing' }
Smalltalks2019CommandLineHandler >> configurationDefinition [

	^ Array
		with: ( MandatoryArgument named: 'port' convertingWith: #asNumber )
		with:
			( OptionalArgument
				named: 'format'
				defaultingTo: 'text/plain'
				convertingWith: [ :string | ZnMimeType fromString: 'text/plain' ] )
]
