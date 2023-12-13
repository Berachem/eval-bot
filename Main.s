		AREA    |.text|, CODE, READONLY
		ENTRY
		EXPORT	__main
	
		IMPORT	MOTEUR_INIT					; initialise les moteurs (configure les pwms + GPIO)
		
		IMPORT	MOTEUR_DROIT_ON				; activer le moteur droit
		IMPORT  MOTEUR_DROIT_OFF			; déactiver le moteur droit
		IMPORT  MOTEUR_DROIT_AVANT			; moteur droit tourne vers l'avant
		IMPORT  MOTEUR_DROIT_ARRIERE		; moteur droit tourne vers l'arrière
		IMPORT  MOTEUR_DROIT_INVERSE		; inverse le sens de rotation du moteur droit
		
		IMPORT	MOTEUR_GAUCHE_ON			; activer le moteur gauche
		IMPORT  MOTEUR_GAUCHE_OFF			; déactiver le moteur gauche
		IMPORT  MOTEUR_GAUCHE_AVANT			; moteur gauche tourne vers l'avant
		IMPORT  MOTEUR_GAUCHE_ARRIERE		; moteur gauche tourne vers l'arrière
		IMPORT  MOTEUR_GAUCHE_INVERSE		; inverse le sens de rotation du moteur gauche
			
		IMPORT BUMPERS_INIT
		IMPORT READ_BUMPER1
		IMPORT READ_BUMPER2
		IMPORT READ_BUMPERS
			
		IMPORT LEDS_INIT
		IMPORT LEDS_SWITCH

__main

	BL BUMPERS_INIT
	BL MOTEUR_INIT	 
	BL LEDS_INIT
	
	BL MOTEUR_DROIT_ON
	BL MOTEUR_GAUCHE_ON
	
	BL MOTEUR_DROIT_AVANT	   
	BL MOTEUR_GAUCHE_AVANT
	
loop
	
	BL LEDS_SWITCH
	
	BL WAIT
	
	BL READ_BUMPER1
	cmp r5,#0x00
	BEQ fin
		
	BL READ_BUMPER2
	cmp r5,#0x00
	BEQ fin
	
	;BL READ_BUMPERS
	;cmp r5, #0
	;BEQ fin
	
	B loop

WAIT	ldr r1, =0xAFFFF 
wait1	
		subs r1, #1
        bne wait1	
		;; retour à la suite du lien de branchement
		BX	LR


fin
	BL MOTEUR_GAUCHE_OFF
	BL MOTEUR_DROIT_OFF

	NOP
	NOP
	END