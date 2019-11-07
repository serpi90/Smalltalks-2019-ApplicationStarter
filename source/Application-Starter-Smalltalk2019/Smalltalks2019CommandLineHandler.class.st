Class {
	#name : #Smalltalks2019CommandLineHandler,
	#superclass : #ApplicationStarterCommandLineHandler,
	#category : #'Application-Starter-Smalltalk2019'
}

{ #category : #accessing }
Smalltalks2019CommandLineHandler class >> commandName [

	" Overwrite this method to provide a short name for this command handler.
	You may pass the commandName as first argument to the image to select this handler"

	^ 'smalltalks2019'
]

{ #category : #accessing }
Smalltalks2019CommandLineHandler class >> description [

	"This method should return a short one-line description of the command"

	^ 'Example Command line handler for Smalltalks 2019, HI!'
]

{ #category : #'private - accessing' }
Smalltalks2019CommandLineHandler class >> logPrefix [

	^ 'Smalltalks 2019 Example'
]

{ #category : #'private - activation' }
Smalltalks2019CommandLineHandler >> basicActivate [
	| port capitalizationPolicy trim |
	port := self configuration at: 'port'.
	capitalizationPolicy := self configuration
		at: 'capitalization-policy'.
	trim := self configuration at: 'trim-blanks'.
	(Smalltalks2019ExampleServer
		deployedOn: port
		changingCaseWith: capitalizationPolicy
		trimBlanks: trim) start
]

{ #category : #'private - accessing' }
Smalltalks2019CommandLineHandler >> configurationDefinition [

	^ {( MandatoryArgument named: 'port' convertingWith: #asNumber ).
	( FlagArgument named: 'trim-blanks' ).
	( OptionalArgument
		named: 'capitalization-policy'
		defaultingTo: 'none'
		convertingWith: [ :arg | 
			Dictionary new
				at: 'none' put: #youself;
				at: 'uppercase' put: #asUppercase;
				at: 'lowercase' put: #asLowercase;
				at: 'titlecase'
					put: [ :string | ' ' join: ( string substrings collect: [ :word | word capitalized ] ) ];
				at: 'capitalized' put: #capitalized;
				at: arg asLowercase
			] )}
]
