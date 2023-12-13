		AREA    |.text|, CODE, READONLY
		ENTRY
		EXPORT	__main
	
		IMPORT	MOTEUR_INIT					; initialise les moteurs (configure les pwms + GPIO)
		
		IMPORT	MOTEUR_DROIT_ON				; activer le moteur droit
		IMPORT  MOTEUR_DROIT_OFF			; d�activer le moteur droit
		IMPORT  MOTEUR_DROIT_AVANT			; moteur droit tourne vers l'avant
		IMPORT  MOTEUR_DROIT_ARRIERE		; moteur droit tourne vers l'arri�re
		IMPORT  MOTEUR_DROIT_INVERSE		; inverse le sens de rotation du moteur droit
		
		IMPORT	MOTEUR_GAUCHE_ON			; activer le moteur gauche
		IMPORT  MOTEUR_GAUCHE_OFF			; d�activer le moteur gauche
		IMPORT  MOTEUR_GAUCHE_AVANT			; moteur gauche tourne vers l'avant
		IMPORT  MOTEUR_GAUCHE_ARRIERE		; moteur gauche tourne vers l'arri�re
		IMPORT  MOTEUR_GAUCHE_INVERSE		; inverse le sens de rotation du moteur gauche
			
		IMPORT BUMPERS_INIT
		IMPORT READ_BUMPER1
		IMPORT READ_BUMPER2
		IMPORT READ_BUMPERS
			
		IMPORT LEDS_INIT
		IMPORT LEDS_SWITCH
			
		IMPORT SWITCH_INIT
		IMPORT READ_SWITCH1
		IMPORT READ_SWITCH2

__main

	BL BUMPERS_INIT
	BL MOTEUR_INIT	 
	BL LEDS_INIT
	BL SWITCH_INIT

go
	BL MOTEUR_DROIT_ON
	BL MOTEUR_GAUCHE_ON
	
	BL MOTEUR_DROIT_AVANT	   
	BL MOTEUR_GAUCHE_AVANT
	
loopgo
	
	BL LEDS_SWITCH
	
	BL WAIT
	
	BL READ_BUMPER1
	cmp r5,#0x00
	BEQ stop
		
	BL READ_BUMPER2
	cmp r5,#0x00
	BEQ stop
	
	;BL READ_BUMPERS
	;cmp r5, #0
	;BEQ fin
	
	B loopgo

WAIT	ldr r1, =0xAFFFF 
wait1	
		subs r1, #1
        bne wait1	
		;; retour � la suite du lien de branchement
		BX	LR


stop
	BL MOTEUR_GAUCHE_OFF
	BL MOTEUR_DROIT_OFF
	
loopstop	
	BL READ_SWITCH1
	CMP r5,#0x00
	BEQ go
	
	B loopstop

	
	

	NOP
	NOP
	END