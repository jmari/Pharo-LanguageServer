Class {
	#name : #PLSDiagnosticsParamsEngine,
	#superclass : #Object,
	#instVars : [
		'document',
		'requestor'
	],
	#category : #'PharoLanguageServer-Structure-Diagnostic'
}

{ #category : #accessing }
PLSDiagnosticsParamsEngine class >> document: aDocument [
	"Document is aDictionary with uri, version, and sourceCode"

	^ self new
		document: aDocument;
		yourself
]

{ #category : #accessing }
PLSDiagnosticsParamsEngine >> computeDiagnostics [
	| ast diagnostics source |
	source := document at: 'text'.
	ast := self class compiler
		transformDoit;
		source: source;
		noPattern: true;
		failBlock: [ nil ];
		requestor: self requestor;
		options: #(+ optionParseErrors);
		parse.
	diagnostics := OrderedCollection new.
	ast
		acceptVisitor:
			(RBParseErrorNodeVisitor new
				visitBlock: [ :aErrorBlock | 
					diagnostics
						add:
							(PLSDiagnostic new
								message: aErrorBlock errorMessage;
								range:
									(PLSRange
										start: (source toLineCharacter: aErrorBlock start)
										end: (source toLineCharacter: aErrorBlock stop))) ]).
	^ PLSPublishDiagnosticsParams new
		diagnostics: diagnostics;
		uri: (document at: 'uri');
		version: (document at: 'version');
		yourself
]

{ #category : #accessing }
PLSDiagnosticsParamsEngine >> document [
	^ document
]

{ #category : #accessing }
PLSDiagnosticsParamsEngine >> document: anObject [
	document := anObject
]

{ #category : #accessing }
PLSDiagnosticsParamsEngine >> requestor [
	^ requestor
]

{ #category : #accessing }
PLSDiagnosticsParamsEngine >> requestor: anObject [
	requestor := anObject
]