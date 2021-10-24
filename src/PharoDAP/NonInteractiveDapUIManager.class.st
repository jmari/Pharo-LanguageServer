Class {
	#name : #NonInteractiveDapUIManager,
	#superclass : #NonInteractiveUIManager,
	#category : #'PharoDAP-Oups'
}

{ #category : #debug }
NonInteractiveDapUIManager >> debugProcess: process context: context label: title fullView: bool notification: notificationString [

	(OupsDebugRequest newForContext: context)
		process: process;
		label: title;
		submit
]
