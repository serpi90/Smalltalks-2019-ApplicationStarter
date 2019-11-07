Class {
	#name : #BaselineOfApplicationStarterSt2019,
	#superclass : #BaselineOf,
	#category : #BaselineOfApplicationStarterSt2019
}

{ #category : #baselines }
BaselineOfApplicationStarterSt2019 >> baseline: spec [
	<baseline>
	spec
		baseline: 'ApplicationStarter'
		with: [ spec
				repository: 'github://ba-st/ApplicationStarter:ease-of-use/source' ].
	spec
		for: #pharo
		do: [ spec
				package: 'Application-Starter-Smalltalk2019'
					with: [ spec requires: 'ApplicationStarter' ];
				group: 'Core' with: 'Application-Starter-Smalltalk2019';
				group: 'default' with: 'Core' ]
]
