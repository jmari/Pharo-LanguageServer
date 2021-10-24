Class {
	#name : #DAPOupsDebuggerSelector,
	#superclass : #OupsSingleDebuggerSelector,
	#category : #'PharoDAP-Oups'
}

{ #category : #iterating }
DAPOupsDebuggerSelector >> nextDebugger [
	^ debuggers pop
]
